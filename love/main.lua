--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.0.0 beta 1
By HTV04
------------------------------------------------------------------------------]]

function love.load()
	-- Load libraries
	baton = require("lib.baton")
	Class = require("lib.class")
	ini = require("lib.ini")
	lovesize = require("lib.lovesize")
	Timer = require("lib.timer")
	
	-- Weeks Engine init
	require("weeks.classes")
	require("weeks.modules")
	
	require("weeks.menu")
	require("weeks.weeks")
	
	require("weeks.tutorial")
	require("weeks.week1")
	require("weeks.week2")
	require("weeks.week3")
	
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
	
	if settings["Video"]["fullscreen"] == "true" then
		love.window.setMode(
			settings["Video"]["width"],
			settings["Video"]["height"],
			{
				fullscreen = true,
				fullscreentype = settings["Video"]["fullscreenType"],
				vsync = tonumber(settings["Video"]["vsync"])
			}
		)
	else
		love.window.setMode(
			settings["Video"]["width"],
			settings["Video"]["height"],
			{
				resizable = true
			}
		)
	end
	
	if settings["Advanced"]["showFps"] == "true" then
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
	dt = math.min(dt, 1/15) -- To prevent game crashes, min 15 FPS (any lower slows down the game)
	
	input:update()
	
	if inMenu then
		menu.update(dt)
	elseif inGame then
		if weekNum == 3 then
			week3.update(dt)
		elseif weekNum == 2 then
			week2.update(dt)
		elseif weekNum == 1 then
			week1.update(dt)
		else
			tutorial.update(dt)
		end
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
				if weekNum == 3 then
					week3.draw()
				elseif weekNum == 2 then
					week2.draw()
				elseif weekNum == 1 then
					week1.draw()
				else
					tutorial.draw()
				end
			end
		love.graphics.pop()
		
		love.graphics.setColor(1, 1, 1) -- Bypass fade effect
		
		if settings.showFps then
			love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5, nil, 0.5, 0.5)
		end
	lovesize.finish()
end
