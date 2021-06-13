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

weekData[2] = {
	init = function()
		weeks.init()
		
		stageBack = Image(love.graphics.newImage("images/week1/stage-back.png"))
		stageFront = Image(love.graphics.newImage("images/week1/stage-front.png"))
		curtains = Image(love.graphics.newImage("images/week1/curtains.png"))
		
		stageFront.y = 400
		curtains.y = -100
		
		enemy = love.filesystem.load("sprites/week1/daddy-dearest.lua")()
		
		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, -110
		boyfriend.x, boyfriend.y = 260, 100
		
		enemyIcon:animate("daddy dearest", false)
		
		weekData[2].load()
	end,
	
	load = function()
		weeks.load()
		
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
		
		weekData[2].initUI()
		
		inst:play()
		weeks.voicesPlay()
	end,
	
	initUI = function()
		weeks.initUI()
		
		if songNum == 3 then
			weeks.generateNotes(love.filesystem.load("charts/week1/dadbattle" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks.generateNotes(love.filesystem.load("charts/week1/fresh" .. songAppend .. ".lua")())
		else
			weeks.generateNotes(love.filesystem.load("charts/week1/bopeebo" .. songAppend .. ".lua")())
		end
	end,
	
	update = function(dt)
		if gameOver then
			if not graphics.isFading then
				if input:pressed("confirm") then
					inst:stop()
					inst = love.audio.newSource("music/game-over-end.ogg", "stream")
					inst:play()
					
					Timer.clear()
					
					cam.x, cam.y = -boyfriend.x, -boyfriend.y
					
					boyfriend:animate("dead confirm", false)
					
					graphics.fadeOut(3, weekData[2].load)
				elseif input:pressed("gameBack") then
					graphics.fadeOut(1, weekData[2].stop)
				end
			end
			
			boyfriend:update(dt)
			
			return
		end
		
		weeks.update(dt)
		
		if enemyFrameTimer >= 12 then
			enemy:animate("idle", true)
			enemyFrameTimer = 0
		end
		enemyFrameTimer = enemyFrameTimer + 24 * dt
		
		if songNum == 1 and musicThres ~= oldMusicThres and math.fmod(musicTime + 500, 480000 / bpm) < 100 then
			boyfriend:animate("hey", false)
			boyfriendFrameTimer = 0
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
		
		if not graphics.isFading and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1
			else
				graphics.fadeOut(1, weekData[2].stop)
				
				return
			end
			
			weekData[2].load()
		end
		
		weeks.updateUI(dt)
	end,
	
	draw = function()
		weeks.draw()
		
		if not inGame or gameOver then return end
		
		love.graphics.push()
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
		love.graphics.pop()
		
		love.graphics.push()
			love.graphics.scale(uiScale.x, uiScale.y)
			
			weeks.drawUI()
		love.graphics.pop()
	end,
	
	stop = function()
		stageBack = nil
		stageFront = nil
		curtains = nil
		
		weeks.stop()
	end
}
