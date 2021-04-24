--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.0.0 beta 1
By HTV04
------------------------------------------------------------------------------]]

function love.load()
	-- Load libraries
	baton = require "lib.baton"
	Class = require "lib.class"
	ini = require "lib.ini"
	lovesize = require "lib.lovesize"
	Timer = require "lib.timer"
	
	-- Load engine
	require "classes"
	require "modules"
	require "menu"
	require "weeks"
	
	-- Load week data
	require "weeks.tutorial"
	require "weeks.week1"
	require "weeks.week2"
	require "weeks.week3"
	
	-- Create, read and apply settings
	if not love.filesystem.getInfo("settings.ini") then
		love.filesystem.write(
			"settings.ini",
			[[
; Friday Night Funkin' Rewritten Settings

[Video]
; Screen/window width and height (you should change this to your device's screen resolution if you are using the "exclusive" fullscreen type).
width=1280
height=720

; Fullscreen settings. If you don't want Vsync (60 FPS cap), set "fullscreenType" to "exclusive", and set "vsync" is set to "0".
fullscreen=false
fullscreenType=desktop
vsync=1

[Advanced]
showFps=false
]]
		)
	end
	
	settings = ini.load("settings.ini")
	
	if ini.readKey(settings, "Video", "fullscreen") == "true" then
		love.window.setMode(
			ini.readKey(settings, "Video", "width"),
			ini.readKey(settings, "Video", "height"),
			{
				fullscreen = true,
				fullscreentype = ini.readKey(settings, "Video", "fullscreenType"),
				vsync = tonumber(ini.readKey(settings, "Video", "vsync"))
			}
		)
	else
		love.window.setMode(
			ini.readKey(settings, "Video", "width"),
			ini.readKey(settings, "Video", "height"),
			{
				vsync = tonumber(ini.readKey(settings, "Video", "vsync")),
				resizable = true
			}
		)
	end
	
	if ini.readKey(settings, "Advanced", "showFps") == "true" then
		settings.showFps = true
	else
		settings.showFps = false
	end
	
	-- Screen init
	lovesize.set(1280, 720)
	
	-- Variables
	font = love.graphics.newFont("fonts/vcr.ttf", 24)
	
	inMenu = true
	weekNum = 0
	songNum = 0
	songDifficulty = 2
	
	storyMode = false
	inGame = false
	gameOver = false
	
	cam = {x = 0, y = 0, sizeX = 0.9, sizeY = 0.9}
	camScale = {x = 0.9, y = 0.9}
	uiScale = {x = 0.7, y = 0.7}
	
	-- Start menu
	menu.init()
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
		weeks[weekNum].update(dt)
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
				weeks[weekNum].draw()
			end
		love.graphics.pop()
		
		love.graphics.setColor(1, 1, 1) -- Bypass fade effect
		
		if settings.showFps then
			love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5, nil, 0.5, 0.5)
		end
	lovesize.finish()
end
