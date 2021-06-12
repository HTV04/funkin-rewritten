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

weekData[5] = {
	init = function()
		bpm = 100
		
		enemyFrameTimer = 0
		boyfriendFrameTimer = 0
		
		sounds = {
			["miss"] = {
				love.audio.newSource("sounds/missnote1.ogg", "static"),
				love.audio.newSource("sounds/missnote2.ogg", "static"),
				love.audio.newSource("sounds/missnote3.ogg", "static")
			},
			["death"] = love.audio.newSource("sounds/fnf_loss_sfx.ogg", "static")
		}
		
		sheets = {
			["icons"] = love.graphics.newImage("images/iconGrid.png")
		}
		
		sprites = {
			["icons"] = love.filesystem.load("sprites/icons.lua")
		}
		
		sunset = Image(love.graphics.newImage("images/limoSunset.png"))
		
		bgLimo = love.filesystem.load("sprites/bg-limo.lua")()
		limoDancer = love.filesystem.load("sprites/limo-dancer.lua")()
		girlfriend = love.filesystem.load("sprites/girlfriend-car.lua")()
		limo = love.filesystem.load("sprites/limo.lua")()
		enemy = love.filesystem.load("sprites/mommy-mearest.lua")()
		boyfriend = love.filesystem.load("sprites/boyfriend-car.lua")()
		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")() -- Used for game over
		
		bgLimo.y = 250
		limoDancer.y = -130
		girlfriend.x, girlfriend.y = 30, -50
		limo.y = 375
		enemy.x, enemy.y = -380, -10
		boyfriend.x, boyfriend.y = 350, -100
		fakeBoyfriend.x, fakeBoyfriend.y = 350, -100
		
		enemyIcon = sprites["icons"]()
		boyfriendIcon = sprites["icons"]()
		
		enemyIcon.y = 350
		enemyIcon.sizeX, enemyIcon.sizeY = 1.5, 1.5
		boyfriendIcon.y = 350
		boyfriendIcon.sizeX, boyfriendIcon.sizeY = -1.5, 1.5
		
		enemyIcon:animate("mommy mearest", false)
		
		for i = 1, 3 do
			sounds["miss"][i]:setVolume(0.25)
		end
		
		weekData[5].load()
	end,
	
	load = function()
		weeks.load()
		
		if songNum == 3 then
			inst = love.audio.newSource("music/Milf_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Milf_Voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/High_Inst.ogg", "stream")
			voices = love.audio.newSource("music/High_Voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/Satin-Panties_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Satin-Panties_Voices.ogg", "stream")
		end
		
		weekData[5].initUI()
		
		inst:play()
		weeks.voicesPlay()
	end,
	
	initUI = function()
		weeks.initUI()
		
		if songNum == 3 then
			weeks.generateNotes(love.filesystem.load("charts/milf" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks.generateNotes(love.filesystem.load("charts/high" .. songAppend .. ".lua")())
		else
			weeks.generateNotes(love.filesystem.load("charts/satin-panties" .. songAppend .. ".lua")())
		end
	end,
	
	update = function(dt)
		if gameOver then
			if graphics.fade[1] == 1 then
				if input:pressed("confirm") then
					inst:stop()
					inst = love.audio.newSource("music/gameOverEnd.ogg", "stream")
					inst:play()
					
					Timer.clear()
					
					cam.x, cam.y = -boyfriend.x, -boyfriend.y
					
					fakeBoyfriend:animate("dead confirm", false)
					
					graphics.fadeOut(3, weekData[5].load)
				elseif input:pressed("gameBack") then
					graphics.fadeOut(1, weekData[5].stop)
				end
			end
			
			fakeBoyfriend:update(dt)
			
			return
		end
		
		weeks.update(dt)
		
		bgLimo:update(dt)
		limoDancer:update(dt)
		limo:update(dt)
		
		if enemyFrameTimer >= 13 then
			enemy:animate("idle", true)
			enemyFrameTimer = 0
		end
		enemyFrameTimer = enemyFrameTimer + 24 * dt
		
		if health >= 80 then
			if enemyIcon.anim.name == "mommy mearest" then
				enemyIcon:animate("mommy mearest losing", false)
			end
		else
			if enemyIcon.anim.name == "mommy mearest losing" then
				enemyIcon:animate("mommy mearest", false)
			end
		end
		
		if graphics.fade[1] == 1 and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1
			else
				graphics.fadeOut(1, weekData[5].stop)
				
				return
			end
			
			weekData[5].load()
		end
		
		weeks.updateUI(dt)
	end,
	
	draw = function()
		weeks.draw()
		
		if not inGame or gameOver then return end
		
		love.graphics.push()
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
		love.graphics.pop()
		
		love.graphics.push()
			love.graphics.scale(uiScale.x, uiScale.y)
			
			weeks.drawUI()
		love.graphics.pop()
	end,
	
	stop = function()
		sunset = nil
		
		bgLimo = nil
		limoDancer = nil
		limo = nil
		fakeBoyfriend = nil
		
		weeks.stop()
	end
}
