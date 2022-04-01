--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v2.0.0

Copyright (C) 2022  HTV04

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
	-- Lua preparation
	math.randomseed(os.time())

	-- Load libraries
	baton = require "lib.baton"
	Class = require "lib.class"
	lovedos = require "lib.lovedos"
	ini = require "lib.ini"
	Timer = require "lib.timer"

	-- Load engine
	require "classes"
	require "modules"
	require "menu"
	require "weeks"

	-- Load week data
	require "weeks.week6"

	-- Create, read, and apply settings
	settingsStr = [[
; Friday Night Funkin' DOS Settings

[Game]
; "Kade Input" disables anti-spam, but counts "Shit" inputs as misses.
kadeInput=false

[Advanced]
; Show debug output, which shows the current FPS and the memory used by the game.
showDebug=false

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings.
[Data]
settingsVer=1
]]

	if love.filesystem.exists("settings.ini") then
		settingsIni = ini.load("settings.ini")

		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "1" then
			love.filesystem.write("settings.ini", settingsStr)
		end
	else
		love.filesystem.write("settings.ini", settingsStr)
	end

	settingsIni = ini.load("settings.ini")
	settings = {}

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

	-- Variables
	inMenu = true
	weekNum = 1
	songNum = 0
	songDifficulty = 2

	storyMode = false
	inGame = false
	gameOver = false

	cam = {x = 0, y = 0}

	-- Start menu
	menu.init()
end

function love.update(dt)
	dt = math.min(dt, 1 / 15) -- 15 FPS minimum for DOS because most CPUs are too slow

	input:update()

	if inMenu then
		menu.update(dt)
	elseif inGame then
		weeks[weekNum].update(dt)
	end

	Timer.update(dt)
end

function love.draw()
	if inMenu then
		menu.draw()
	elseif inGame then
		weeks[weekNum].draw()
	end

	love.graphics.setColor(255, 255, 255)

	if settings.showDebug then
		love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nMEM USAGE: " .. tostring(love.system.getMemUsage()), 5, 5)
	end
end
