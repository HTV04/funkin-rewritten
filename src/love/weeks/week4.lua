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

local sunset

local bgLimo, limoDancer, limo

return {
	enter = function(self)
		bpm = 100
		
		enemyFrameTimer = 0
		boyfriendFrameTimer = 0
		
		sounds = {
			["miss"] = {
				love.audio.newSource("sounds/miss1.ogg", "static"),
				love.audio.newSource("sounds/miss2.ogg", "static"),
				love.audio.newSource("sounds/miss3.ogg", "static")
			},
			["death"] = love.audio.newSource("sounds/death.ogg", "static")
		}
		
		images = {
			["icons"] = love.graphics.newImage(graphics.imagePath("icons")),
			["notes"] = love.graphics.newImage(graphics.imagePath("notes")),
			["numbers"] = love.graphics.newImage(graphics.imagePath("numbers"))
		}
		
		sprites = {
			["icons"] = love.filesystem.load("sprites/icons.lua"),
			["numbers"] = love.filesystem.load("sprites/numbers.lua")
		}
		
		sunset = Image(love.graphics.newImage(graphics.imagePath("week4/sunset")))
		
		
		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")() -- Used for game over
		bgLimo = love.filesystem.load("sprites/week4/bg-limo.lua")()
		limoDancer = love.filesystem.load("sprites/week4/limo-dancer.lua")()
		girlfriend = love.filesystem.load("sprites/week4/girlfriend.lua")()
		limo = love.filesystem.load("sprites/week4/limo.lua")()
		enemy = love.filesystem.load("sprites/week4/mommy-mearest.lua")()
		boyfriend = love.filesystem.load("sprites/week4/boyfriend.lua")()
		rating = love.filesystem.load("sprites/rating.lua")()
		
		fakeBoyfriend.x, fakeBoyfriend.y = 350, -100
		bgLimo.y = 250
		limoDancer.y = -130
		girlfriend.x, girlfriend.y = 30, -50
		limo.y = 375
		enemy.x, enemy.y = -380, -10
		boyfriend.x, boyfriend.y = 340, -100
		
		rating = love.filesystem.load("sprites/rating.lua")()
		
		rating.sizeX, rating.sizeY = 0.75, 0.75
		numbers = {}
		for i = 1, 3 do
			numbers[i] = sprites["numbers"]()
			
			numbers[i].sizeX, numbers[i].sizeY = 0.5, 0.5
		end
		
		enemyIcon = sprites["icons"]()
		boyfriendIcon = sprites["icons"]()
		
		if settings.downscroll then
			enemyIcon.y = -400
			boyfriendIcon.y = -400
		else
			enemyIcon.y = 350
			boyfriendIcon.y = 350
		end
		enemyIcon.sizeX, enemyIcon.sizeY = 1.5, 1.5
		boyfriendIcon.sizeX, boyfriendIcon.sizeY = -1.5, 1.5
		
		enemyIcon:animate("mommy mearest", false)
		
		for i = 1, 3 do
			sounds["miss"][i]:setVolume(0.25)
		end
		
		self:load()
	end,
	
	load = function(self)
		weeks:load()
		
		if songNum == 3 then
			inst = love.audio.newSource("music/week4/milf-inst.ogg", "stream")
			voices = love.audio.newSource("music/week4/milf-voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/week4/high-inst.ogg", "stream")
			voices = love.audio.newSource("music/week4/high-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/week4/satin-panties-inst.ogg", "stream")
			voices = love.audio.newSource("music/week4/satin-panties-voices.ogg", "stream")
		end
		
		self:initUI()
		
		inst:play()
		weeks:voicesPlay()
	end,
	
	initUI = function(self)
		weeks:initUI()
		
		if songNum == 3 then
			weeks:generateNotes(love.filesystem.load("charts/week4/milf" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks:generateNotes(love.filesystem.load("charts/week4/high" .. songAppend .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/week4/satin-panties" .. songAppend .. ".lua")())
		end
	end,
	
	update = function(self, dt)
		if gameOver then
			if graphics.fade[1] == 1 then
				if input:pressed("confirm") then
					inst:stop()
					inst = love.audio.newSource("music/game-over-end.ogg", "stream")
					inst:play()
					
					Timer.clear()
					
					cam.x, cam.y = -fakeBoyfriend.x, -fakeBoyfriend.y
					
					fakeBoyfriend:animate("dead confirm", false)
					
					graphics.fadeOut(3, function() self:load() end)
				elseif input:pressed("gameBack") then
					graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
				end
			end
			
			fakeBoyfriend:update(dt)
			
			return
		end
		
		weeks:update(dt)
		
		-- Hardcoded M.I.L.F camera scaling
		if songNum == 3 and musicTime > 56000 and musicTime < 67000 and musicThres ~= oldMusicThres and math.fmod(musicTime, 60000 / bpm) < 100 then
			if camScaleTimer then Timer.cancel(camScaleTimer) end
			
			camScaleTimer = Timer.tween((60 / bpm) / 16, cam, {sizeX = camScale.x * 1.05, sizeY = camScale.y * 1.05}, "out-quad", function() camScaleTimer = Timer.tween((60 / bpm), cam, {sizeX = camScale.x, sizeY = camScale.y}, "out-quad") end)
		end
		
		bgLimo:update(dt)
		limoDancer:update(dt)
		limo:update(dt)
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 120000 / bpm) < 100 then
			limoDancer:animate("anim", false)
			
			limoDancer.anim.speed = 14.4 / (60 / bpm)
		end
		
		if health >= 80 then
			if enemyIcon.anim.name == "mommy mearest" then
				enemyIcon:animate("mommy mearest losing", false)
			end
		else
			if enemyIcon.anim.name == "mommy mearest losing" then
				enemyIcon:animate("mommy mearest", false)
			end
		end
		
		if graphics.fade[1] == 1 and not inst:isPlaying() and not voices:isPlaying() then
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
				love.graphics.translate(cam.x * 0.5, cam.y * 0.5)
				
				sunset:draw()
				
				bgLimo:draw()
				for i = -475, 725, 400 do
					limoDancer.x = i
					
					limoDancer:draw()
				end
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
				girlfriend:draw()
				limo:draw()
				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			weeks:drawRating(1)
		love.graphics.pop()
		
		weeks:drawUI()
	end,
	
	leave = function()
		sunset = nil
		
		bgLimo = nil
		limoDancer = nil
		limo = nil
		
		weeks:leave()
	end
}
