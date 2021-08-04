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
		
		enemy = girlfriend -- For compatibility with weeks
		
		girlfriend.x, girlfriend.y = 30, -90
		boyfriend.x, boyfriend.y = 260, 100
		
		enemyIcon:animate("girlfriend", false)
		
		self:load()
	end,
	
	load = function(self)
		weeks:load()
		
		inst = nil
		voices = love.audio.newSource("music/tutorial/tutorial.ogg", "stream")
		
		self:initUI(songNum)
		
		weeks:voicesPlay()
	end,
	
	initUI = function(self)
		weeks:initUI()
		
		weeks:generateNotes(love.filesystem.load("charts/tutorial/tutorial" .. songAppend .. ".lua")())
	end,
	
	update = function(self, dt)
		if gameOver then
			if not graphics.isFading then
				if input:pressed("confirm") then
					if inst then -- In case "confirm" is pressed before game over music starts
						inst:stop()
					end
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
			
		oldMusicThres = musicThres
		
		musicTime = musicTime + (love.timer.getTime() * 1000) - previousFrameTime
		previousFrameTime = love.timer.getTime() * 1000
		
		if voices:tell("seconds") * 1000 ~= lastReportedPlaytime then
			musicTime = (musicTime + (voices:tell("seconds") * 1000)) / 2
			lastReportedPlaytime = voices:tell("seconds") * 1000
		end
		
		musicThres = math.floor(musicTime / 100) -- Since "musicTime" isn't precise, this is needed
		
		for i = 1, #events do
			if events[i].eventTime <= musicTime then
				local oldBpm = bpm
				
				if events[i].bpm then
					bpm = events[i].bpm
					if not bpm then bpm = oldBpm end
				end
				
				if camTimer then
					Timer.cancel(camTimer)
				end
				if events[i].mustHitSection then
					camTimer = Timer.tween(1.5, cam, {x = -boyfriend.x + 50, y = -boyfriend.y + 50}, "out-quad")
				else
					camTimer = Timer.tween(1.5, cam, {x = -girlfriend.x - 100, y = -girlfriend.y + 75}, "out-quad")
				end
				
				table.remove(events, i)
				
				break
			end
		end
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 240000 / bpm) < 100 then
			if camScaleTimer then Timer.cancel(camScaleTimer) end
			
			camScaleTimer = Timer.tween((60 / bpm) / 16, cam, {sizeX = camScale.x * 1.05, sizeY = camScale.y * 1.05}, "out-quad", function() camScaleTimer = Timer.tween((60 / bpm), cam, {sizeX = camScale.x, sizeY = camScale.y}, "out-quad") end)
		end
		
		girlfriend:update(dt)
		boyfriend:update(dt)
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 120000 / bpm) < 100 then
			spriteTimers[1] = math.max(spriteTimers[1], spriteTimers[2]) -- Gross hack, but whatever
			
			if spriteTimers[1] == 0 then
				girlfriend:animate("idle", false)
			end
			if spriteTimers[3] == 0 then
				weeks:safeAnimate(boyfriend, "idle", false, 3)
			end
			
			girlfriend.anim.speed = 14.4 / (60 / bpm)
		end
		
		for i = 1, 3 do
			local spriteTimer = spriteTimers[i]
			
			if spriteTimer > 0 then
				spriteTimers[i] = spriteTimer - 1
			end
		end
		
		if not graphics.isFading and not voices:isPlaying() then
			storyMode = false
			
			graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
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
