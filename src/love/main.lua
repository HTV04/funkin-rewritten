--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.0.0 beta 3

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
	Timer = require "lib.timer"
	
	-- Load objects
	require "classes"
	require "modules"
	
	-- Create, read, and apply settings
	settingsStr = [[
; Friday Night Funkin' Rewritten Settings

[Video]
; Screen/window width and height (you should change this to your device's screen resolution if you are using the "exclusive" fullscreen type)
; NOTE: These settings will be ignored if using the "desktop" fullscreen type
width=1280
height=720

; Fullscreen settings, if you don't want Vsync (60 FPS cap), set "fullscreenType" to "exclusive", and set "vsync" is set to "0"
fullscreen=false
fullscreenType=desktop
vsync=1

; Use hardware-compressed image formats to save RAM, disabling this may improve performance at the cost of eating your RAM for breakfast (and increasing load times)
; WARNING: Don't disable this on 32-bit versions of the game, or the game will quickly run out of memory (thanks to the 2 GB RAM cap)
; NOTE: If hardware compression is not supported on your device, this option will be silently disabled
hardwareCompression=true

[Game]
; "Kade Input" disables anti-spam, but counts "Shit" inputs as misses
; NOTE: Currently unfinished, some aspects of this input mode still need to be implemented, like mash violations
kadeInput=false

[Advanced]
; Show debug info on the screen at all times
showDebug=false

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings!
[Data]
settingsVer=2
]]
	
	if love.filesystem.getInfo("settings.ini") then
		settingsIni = ini.load("settings.ini")
		
		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "2" then
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
		if love.graphics.getImageFormats()["DXT5"] then
			graphics.imageType = "dds"
		end
	end
	
	if ini.readKey(settingsIni, "Game", "kadeInput") == "true" then
		settings.kadeInput = true
	else
		settings.kadeInput = false
	end
	
	if ini.readKey(settingsIni, "Advanced", "showDebug") == "true" then
		settings.showDebug = true
	else
		settings.showDebug = false
	end
	
	-- Load engine
	require "menu"
	require "weeks"
	
	-- Load week data
	weekData = {}
	require "weeks.tutorial"
	require "weeks.week1"
	require "weeks.week2"
	require "weeks.week3"
	require "weeks.week4"
	
	-- Screen init
	lovesize.set(1280, 720)
	
	-- Variables
	font = love.graphics.newFont("fonts/vcr.ttf", 24)
	
	weekNum = 1
	songDifficulty = 2
	
	cam = {x = 0, y = 0, sizeX = 0.9, sizeY = 0.9}
	camScale = {x = 0.9, y = 0.9}
	uiScale = {x = 0.7, y = 0.7}
	
	-- Start menu
	menu.load()
end

function love.keypressed(key)
	if key == "7" then
		love.filesystem.createDirectory("screenshots")
		
		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
	end
end

function love.resize(width, height)
    lovesize.resize(width, height)
end

function love.update(dt)
	dt = math.min(dt, 1 / 30)
	
	input:update()
	
	if inMenu then
		menu.update(dt)
	elseif inGame then
		weekData[weekNum].update(dt)
	end
	
	Timer.update(dt)
end

function love.draw()
	graphics.setColor(1, 1, 1)
	love.graphics.setFont(font)
	
	lovesize.begin()
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			
			if inMenu then
				menu.draw()
			elseif inGame then
				weekData[weekNum].draw()
			end
		love.graphics.pop()
		
		love.graphics.setColor(1, 1, 1) -- Bypass fade effect
		
		if settings.showDebug then
			love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5, nil, 0.5, 0.5)
		end
	lovesize.finish()
end
