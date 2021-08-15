--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.0.1

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

function love.load()
	-- Load libraries
	baton = require "lib.baton"
	Class = require "lib.class"
	ini = require "lib.ini"
	lovesize = require "lib.lovesize"
	Gamestate = require "lib.gamestate"
	Timer = require "lib.timer"

	-- Load modules
	engine = require "modules.engine"
	audio = require "modules.audio"
	graphics = require "modules.graphics"
	input = require "modules.input"

	-- Create, read, and apply settings
	settingsStr = [[
; Friday Night Funkin' Rewritten Settings

[Video]
; Screen/window width and height (you should change this to your device's screen resolution if you are using the "exclusive" fullscreen type)
; NOTE: These settings will be ignored if using the "desktop" fullscreen type
width=1280
height=720

; Fullscreen settings, if you don't want Vsync (60 FPS cap), set "fullscreenType" to "exclusive" and "vsync" to "0"
fullscreen=false
fullscreenType=desktop
vsync=1

; Use hardware-compressed image formats to save RAM, disabling this will make the game eat your RAM for breakfast (and increase load times)
; WARNING: Don't disable this on 32-bit versions of the game, or the game will quickly run out of memory and crash (thanks to the 2 GB RAM cap)
; NOTE: If hardware compression is not supported on your device, this option will be silently ignored
hardwareCompression=true

[Audio]
; Master volume
; Possible values: 0.0-1.0
volume=1.0

[Game]
; "Downscroll" makes arrows scroll down instead of up, and also moves some aspects of the UI around
downscroll=false

; "Kade Input" disables anti-spam, but counts "Shit" inputs as misses
; NOTE: Currently unfinished, some aspects of this input mode still need to be implemented, like mash violations
kadeInput=false

[Advanced]
; Show debug info on the screen
; Possible values: false, fps, detailed
showDebug=false

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings!
[Data]
settingsVer=3
]]

	if love.filesystem.getInfo("settings.ini") then
		settingsIni = ini.load("settings.ini")

		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "3" then
			love.window.showMessageBox("Warning", "The current settings file is outdated, and will now be reset.")

			local success, message = love.filesystem.write("settings.ini", settingsStr)

			if success then
				love.window.showMessageBox("Success", "Settings file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
			else
				love.window.showMessageBox("Error", message)
			end
		end
	else
		local success, message = love.filesystem.write("settings.ini", settingsStr)

		if success then
			love.window.showMessageBox("Success", "Settings file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
		else
			love.window.showMessageBox("Error", message)
		end
	end

	settingsIni = ini.load("settings.ini")
	settings = {}

	if ini.readKey(settingsIni, "Video", "fullscreen") == "true" then
		love.window.setMode(
			ini.readKey(settingsIni, "Video", "width"),
			ini.readKey(settingsIni, "Video", "height"),
			{
				fullscreen = true,
				fullscreentype = ini.readKey(settingsIni, "Video", "fullscreenType"),
				vsync = tonumber(ini.readKey(settingsIni, "Video", "vsync"))
			}
		)
	else
		love.window.setMode(
			ini.readKey(settingsIni, "Video", "width"),
			ini.readKey(settingsIni, "Video", "height"),
			{
				vsync = tonumber(ini.readKey(settingsIni, "Video", "vsync")),
				resizable = true
			}
		)
	end
	if ini.readKey(settingsIni, "Video", "hardwareCompression") == "true" then
		settings.hardwareCompression = true

		if love.graphics.getImageFormats()["DXT5"] then
			graphics.setImageType("dds")
		end
	else
		settings.hardwareCompression = false
	end

	love.audio.setVolume(tonumber(ini.readKey(settingsIni, "Audio", "volume")))

	if ini.readKey(settingsIni, "Game", "downscroll") == "true" then
		settings.downscroll = true
	else
		settings.downscroll = false
	end
	if ini.readKey(settingsIni, "Game", "kadeInput") == "true" then
		settings.kadeInput = true
	else
		settings.kadeInput = false
	end

	if ini.readKey(settingsIni, "Advanced", "showDebug") == "fps" or ini.readKey(settingsIni, "Advanced", "showDebug") == "detailed" then
		settings.showDebug = ini.readKey(settingsIni, "Advanced", "showDebug")
	else
		settings.showDebug = false
	end

	-- Load engine
	debugMenu = require "debug-menu"
	menu = require "menu"
	weeks = require "weeks"

	-- Load week data
	weekData = {
		require "weeks.tutorial",
		require "weeks.week1",
		require "weeks.week2",
		require "weeks.week3",
		require "weeks.week4",
		require "weeks.week5"
	}

	-- Screen init
	lovesize.set(1280, 720)

	graphics.loveResize(love.graphics.getWidth(), love.graphics.getHeight())

	-- Variables
	font = love.graphics.newFont("fonts/vcr.ttf", 24)
	isLoading = false

	weekNum = 1
	songDifficulty = 2

	spriteTimers = {
		0, -- Girlfriend
		0, -- Enemy
		0 -- Boyfriend
	}

	cam = {x = 0, y = 0, sizeX = 0.9, sizeY = 0.9}
	camScale = {x = 0.9, y = 0.9}
	uiScale = {x = 0.7, y = 0.7}

	musicTime = 0
	health = 0

	Gamestate.switch(menu)
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
	elseif key == "7" then
		Gamestate.switch(debugMenu)
	else
		Gamestate.keypressed(key)
	end
end

function love.resize(width, height)
	lovesize.resize(width, height)

	graphics.loveResize(width, height)
end

function love.update(dt)
	dt = math.min(dt, 1 / 30)

	input:update()

	Gamestate.update(dt)

	Timer.update(dt)
end

function love.draw()
	love.graphics.setFont(font)

	lovesize.begin()
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.draw()
		love.graphics.setColor(1, 1, 1) -- Fade effect off

		if isLoading then
			love.graphics.print("Loading...", graphics.loveWidth() - 175, graphics.loveHeight() - 50)
		end
	lovesize.finish()

	-- Debug output
	if settings.showDebug then
		love.graphics.print(engine.getDebugStr(settings.showDebug), 5, 5, nil, 0.5, 0.5)
	end
end
