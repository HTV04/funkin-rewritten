--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

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

local sky, city, cityWindows, behindTrain, street
local winColors, winColor

return {
	enter = function(self)
		weeks:enter()
		
		cam.sizeX, cam.sizeY = 1, 1
		camScale.x, camScale.y = 1, 1
		
		winColors = {
			{49, 162, 253}, -- Blue
			{49, 253, 140}, -- Green
			{251, 51, 245}, -- Magenta
			{253, 69, 49}, -- Orange
			{251, 166, 51}, -- Yellow
		}
		winColor = 1
		
		sky = Image(love.graphics.newImage(graphics.imagePath("week3/sky")))
		city = Image(love.graphics.newImage(graphics.imagePath("week3/city")))
		cityWindows = Image(love.graphics.newImage(graphics.imagePath("week3/city-windows")))
		behindTrain = Image(love.graphics.newImage(graphics.imagePath("week3/behind-train")))
		street = Image(love.graphics.newImage(graphics.imagePath("week3/street")))
		
		behindTrain.y = -100
		behindTrain.sizeX, behindTrain.sizeY = 1.25, 1.25
		street.y = -100
		street.sizeX, street.sizeY = 1.25, 1.25
		
		enemy = love.filesystem.load("sprites/week3/pico-enemy.lua")()
		
		girlfriend.x, girlfriend.y = -70, -140
		enemy.x, enemy.y = -480, 50
		enemy.sizeX = -1 -- Reverse, reverse!
		boyfriend.x, boyfriend.y = 165, 50
		
		enemyIcon:animate("pico", false)
		
		self:load()
	end,
	
	load = function(self)
		weeks:load()
		
		if songNum == 3 then
			inst = love.audio.newSource("music/week3/blammed-inst.ogg", "stream")
			voices = love.audio.newSource("music/week3/blammed-voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/week3/philly-nice-inst.ogg", "stream")
			voices = love.audio.newSource("music/week3/philly-nice-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/week3/pico-inst.ogg", "stream")
			voices = love.audio.newSource("music/week3/pico-voices.ogg", "stream")
		end
		
		self:initUI()
		
		inst:play()
		weeks:voicesPlay()
	end,
	
	initUI = function(self)
		weeks:initUI()
		
		if songNum == 3 then
			weeks:generateNotes(love.filesystem.load("charts/week3/blammed" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks:generateNotes(love.filesystem.load("charts/week3/philly-nice" .. songAppend .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/week3/pico" .. songAppend .. ".lua")())
		end
	end,
	
	update = function(self, dt)
		if gameOver then
			if not graphics.isFading then
				if input:pressed("confirm") then
					inst:stop()
					inst = love.audio.newSource("music/game-over-end.ogg", "stream")
					inst:play()
					
					Timer.clear()
					
					cam.x, cam.y = -boyfriend.x, -boyfriend.y
					
					boyfriend:animate("dead confirm", false)
					
					graphics.fadeOut(3, function() self:load() end)
				elseif input:pressed("gameBack") then
					graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
				end
			end
			
			boyfriend:update(dt)
			
			return
		end
		
		weeks:update(dt)
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 240000 / bpm) < 100 then
			winColor = winColor + 1
			
			if winColor > 5 then
				winColor = 1
			end
		end
		
		if health >= 80 then
			if enemyIcon.anim.name == "pico" then
				enemyIcon:animate("pico losing", false)
			end
		else
			if enemyIcon.anim.name == "pico losing" then
				enemyIcon:animate("pico", false)
			end
		end
		
		if not graphics.isFading and not inst:isPlaying() and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1
				
				self:load()
			else
				graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
			end
		end
		
		weeks:updateUI(dt)
	end,
	
	draw = function(self)
		local curWinColor = winColors[winColor]
		
		weeks:draw()
		
		if gameOver then return end
		
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)
			
			love.graphics.push()
				love.graphics.translate(cam.x * 0.25, cam.y * 0.25)
				
				sky:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.5, cam.y * 0.5)
				
				city:draw()
				graphics.setColor(curWinColor[1] / 255, curWinColor[2] / 255, curWinColor[3] / 255)
				cityWindows:draw()
				graphics.setColor(1, 1, 1)
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)
				
				behindTrain:draw()
				street:draw()
				
				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
		
		weeks:drawUI()
	end,
	
	leave = function(self)
		sky = nil
		city = nil
		cityWindows = nil
		behindTrain = nil
		street = nil
		
		weeks:leave()
	end
}
