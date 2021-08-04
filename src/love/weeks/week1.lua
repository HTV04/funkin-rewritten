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

local stageBack, stageFront, curtains

return {
	enter = function(self)
		weeks:enter()
		
		stageBack = Image(love.graphics.newImage(graphics.imagePath("week1/stage-back")))
		stageFront = Image(love.graphics.newImage(graphics.imagePath("week1/stage-front")))
		curtains = Image(love.graphics.newImage(graphics.imagePath("week1/curtains")))
		
		stageFront.y = 400
		curtains.y = -100
		
		enemy = love.filesystem.load("sprites/week1/daddy-dearest.lua")()
		
		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, -110
		boyfriend.x, boyfriend.y = 260, 100
		
		enemyIcon:animate("daddy dearest", false)
		
		self:load()
	end,
	
	load = function(self)
		weeks:load()
		
		if songNum == 3 then
			inst = love.audio.newSource("music/week1/dadbattle-inst.ogg", "stream")
			voices = love.audio.newSource("music/week1/dadbattle-voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/week1/fresh-inst.ogg", "stream")
			voices = love.audio.newSource("music/week1/fresh-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/week1/bopeebo-inst.ogg", "stream")
			voices = love.audio.newSource("music/week1/bopeebo-voices.ogg", "stream")
		end
		
		self:initUI()
		
		inst:play()
		weeks:voicesPlay()
	end,
	
	initUI = function(self)
		weeks:initUI()
		
		if songNum == 3 then
			weeks:generateNotes(love.filesystem.load("charts/week1/dadbattle" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks:generateNotes(love.filesystem.load("charts/week1/fresh" .. songAppend .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/week1/bopeebo" .. songAppend .. ".lua")())
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
		
		if songNum == 1 and musicThres ~= oldMusicThres and math.fmod(musicTime + 500, 480000 / bpm) < 100 then
			boyfriend:animate("hey", false)
		end
		
		if health >= 80 then
			if enemyIcon.anim.name == "daddy dearest" then
				enemyIcon:animate("daddy dearest losing", false)
			end
		else
			if enemyIcon.anim.name == "daddy dearest losing" then
				enemyIcon:animate("daddy dearest", false)
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
		weeks:draw()
		
		if gameOver then return end
		
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)
			
			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)
				
				stageBack:draw()
				stageFront:draw()
				
				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
				
				curtains:draw()
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
		
		weeks:drawUI()
	end,
	
	leave = function(self)
		stageBack = nil
		stageFront = nil
		curtains = nil
		
		weeks:leave()
	end
}
