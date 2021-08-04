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

local walls, escalator, christmasTree, snow -- Images

local topBop, bottomBop, santa -- Sprites

local scaryIntro = false

return {
	enter = function(self)
		cam.sizeX, cam.sizeY = 0.7, 0.7
		camScale.x, camScale.y = 0.7, 0.7
		
		bpm = 100
		useAltAnims = false
		
		enemyFrameTimer = 0
		boyfriendFrameTimer = 0
		
		sounds = {
			["miss"] = {
				love.audio.newSource("sounds/miss1.ogg", "static"),
				love.audio.newSource("sounds/miss2.ogg", "static"),
				love.audio.newSource("sounds/miss3.ogg", "static")
			},
			["death"] = love.audio.newSource("sounds/death.ogg", "static"),
			["lights off"] = love.audio.newSource("sounds/week5/lights-off.ogg", "static"),
			["lights on"] = love.audio.newSource("sounds/week5/lights-on.ogg", "static")
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
		
		walls = Image(love.graphics.newImage(graphics.imagePath("week5/walls")))
		escalator = Image(love.graphics.newImage(graphics.imagePath("week5/escalator")))
		christmasTree = Image(love.graphics.newImage(graphics.imagePath("week5/christmas-tree")))
		snow = Image(love.graphics.newImage(graphics.imagePath("week5/snow")))
		
		escalator.x = 125
		christmasTree.x = 75
		snow.y = 850
		snow.sizeX, snow.sizeY = 2, 2
		
		topBop = love.filesystem.load("sprites/week5/top-bop.lua")()
		bottomBop = love.filesystem.load("sprites/week5/bottom-bop.lua")()
		girlfriend = love.filesystem.load("sprites/week5/girlfriend.lua")()
		santa = love.filesystem.load("sprites/week5/santa.lua")()
		enemy = love.filesystem.load("sprites/week5/dearest-duo.lua")()
		boyfriend = love.filesystem.load("sprites/week5/boyfriend.lua")()
		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")() -- Used for game over
		
		rating = love.filesystem.load("sprites/rating.lua")()
		
		topBop.x, topBop.y = 60, -250
		bottomBop.x, bottomBop.y = -75, 375
		girlfriend.x, girlfriend.y = -50, 410
		santa.x, santa.y = -1350, 410
		enemy.x, enemy.y = -780, 410
		boyfriend.x, boyfriend.y = 300, 620
		fakeBoyfriend.x, fakeBoyfriend.y = 300, 620
		
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
		
		enemyIcon:animate("dearest duo", false)
		
		for i = 1, 3 do
			sounds["miss"][i]:setVolume(0.25)
		end
		
		self:load()
	end,
	
	load = function(self)
		weeks:load()
		
		if songNum == 3 then
			camScale.x, camScale.y = 0.9, 0.9
			
			if scaryIntro then
				cam.x, cam.y = -150, 750
				cam.sizeX, cam.sizeY = 2.5, 2.5
				
				graphics.cancelTimer()
				graphics.fade[1] = 1
			else
				cam.sizeX, cam.sizeY = 0.9, 0.9
			end
			
			walls = Image(love.graphics.newImage(graphics.imagePath("week5/evil-bg")))
			christmasTree = Image(love.graphics.newImage(graphics.imagePath("week5/evil-tree")))
			snow = Image(love.graphics.newImage(graphics.imagePath("week5/evil-snow")))
			
			walls.y = -250
			christmasTree.x = 75
			christmasTree.sizeX, christmasTree.sizeY = 0.5, 0.5
			snow.x, snow.y = -50, 770
			
			enemy = love.filesystem.load("sprites/week5/monster.lua")()
			
			enemy.x, enemy.y = -780, 420
			
			enemyIcon:animate("monster", false)
			
			inst = love.audio.newSource("music/week5/winter-horrorland-inst.ogg", "stream")
			voices = love.audio.newSource("music/week5/winter-horrorland-voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/week5/eggnog-inst.ogg", "stream")
			voices = love.audio.newSource("music/week5/eggnog-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/week5/cocoa-inst.ogg", "stream")
			voices = love.audio.newSource("music/week5/cocoa-voices.ogg", "stream")
		end
		
		self:initUI()
		
		if scaryIntro then
			Timer.after(
				5,
				function()
					scaryIntro = false
					
					camTimer = Timer.tween(2, cam, {x = -boyfriend.x + 100, y = -boyfriend.y + 75, sizeX = 0.9, sizeY = 0.9}, "out-quad")
					
					inst:play()
					weeks:voicesPlay()
				end
			)
			
			audio.playSound(sounds["lights on"])
		else
			inst:play()
			weeks:voicesPlay()
		end
	end,
	
	initUI = function(self)
		weeks:initUI()
		
		if songNum == 3 then
			weeks:generateNotes(love.filesystem.load("charts/week5/winter-horrorland" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks:generateNotes(love.filesystem.load("charts/week5/eggnog" .. songAppend .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/week5/cocoa" .. songAppend .. ".lua")())
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
		
		if not scaryIntro then
			weeks:update(dt)
			
			if songNum ~= 3 then
				topBop:update(dt)
				bottomBop:update(dt)
				santa:update(dt)
				
				if musicThres ~= oldMusicThres and math.fmod(musicTime, 60000 / bpm) < 100 then
					topBop:animate("anim", false)
					bottomBop:animate("anim", false)
					santa:animate("anim", false)
				end
			end
			
			if songNum == 3 then
				if health >= 80 then
					if enemyIcon.anim.name == "monster" then
						enemyIcon:animate("monster losing", false)
					end
				else
					if enemyIcon.anim.name == "monster losing" then
						enemyIcon:animate("monster", false)
					end
				end
			else
				if health >= 80 then
					if enemyIcon.anim.name == "dearest duo" then
						enemyIcon:animate("dearest duo losing", false)
					end
				else
					if enemyIcon.anim.name == "dearest duo losing" then
						enemyIcon:animate("dearest duo", false)
					end
				end
			end
			
			if not scaryIntro and not graphics.isFading and not inst:isPlaying() and not voices:isPlaying() then
				if storyMode and songNum < 3 then
					songNum = songNum + 1
					
					-- Winter Horrorland setup
					if songNum == 3 then
						scaryIntro = true
						
						audio.playSound(sounds["lights off"])
						
						graphics.cancelTimer()
						graphics.fade[1] = 0
						
						Timer.after(3, function() self:load() end)
					else
						self:load()
					end
				else
					graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
				end
			end
			
			weeks:updateUI(dt)
		end
	end,
	
	draw = function(self)
		weeks:draw()
		
		if gameOver then return end
		
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)
			
			love.graphics.push()
				love.graphics.translate(cam.x * 0.5, cam.y * 0.5)
				
				walls:draw()
				if songNum ~= 3 then
					topBop:draw()
					escalator:draw()
				end
				christmasTree:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)
				
				if songNum ~= 3 then
					bottomBop:draw()
				end
				
				snow:draw()
				
				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
				if songNum ~= 3 then
					santa:draw()
				end
				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
			
		if not scaryIntro then
			love.graphics.push()
				love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
				love.graphics.scale(0.7, 0.7)
				
				for i = 1, 4 do
					if enemyArrows[i].anim.name == "off" then
						graphics.setColor(0.6, 0.6, 0.6)
					end
					enemyArrows[i]:draw()
					graphics.setColor(1, 1, 1)
					boyfriendArrows[i]:draw()
					
					love.graphics.push()
						love.graphics.translate(0, -musicPos)
						
						for j = #enemyNotes[i], 1, -1 do
							if (not settings.downscroll and enemyNotes[i][j].y - musicPos <= 560) or (settings.downscroll and enemyNotes[i][j].y - musicPos >= -560) then
								local animName = enemyNotes[i][j].anim.name
								
								if animName == "hold" or animName == "end" then
									graphics.setColor(1, 1, 1, 0.5)
								end
								enemyNotes[i][j]:draw()
								graphics.setColor(1, 1, 1)
							end
						end
						for j = #boyfriendNotes[i], 1, -1 do
							if (not settings.downscroll and boyfriendNotes[i][j].y - musicPos <= 560) or (settings.downscroll and boyfriendNotes[i][j].y - musicPos >= -560) then
								local animName = boyfriendNotes[i][j].anim.name
								
								if settings.downscroll then
									if animName == "hold" or animName == "end" then
										graphics.setColor(1, 1, 1, math.min(0.5, (500 - (boyfriendNotes[i][j].y - musicPos)) / 150))
									else
										graphics.setColor(1, 1, 1, math.min(1, (500 - (boyfriendNotes[i][j].y - musicPos)) / 75))
									end
								else
									if animName == "hold" or animName == "end" then
										graphics.setColor(1, 1, 1, math.min(0.5, (500 + (boyfriendNotes[i][j].y - musicPos)) / 150))
									else
										graphics.setColor(1, 1, 1, math.min(1, (500 + (boyfriendNotes[i][j].y - musicPos)) / 75))
									end
								end
								boyfriendNotes[i][j]:draw()
							end
						end
						graphics.setColor(1, 1, 1)
					love.graphics.pop()
				end
				
				if settings.downscroll then
					graphics.setColor(1, 0, 0)
					love.graphics.rectangle("fill", -500, -400, 1000, 25)
					graphics.setColor(0, 1, 0)
					love.graphics.rectangle("fill", 500, -400, -health * 10, 25)
					graphics.setColor(0, 0, 0)
					love.graphics.setLineWidth(10)
					love.graphics.rectangle("line", -500, -400, 1000, 25)
					love.graphics.setLineWidth(1)
					graphics.setColor(1, 1, 1)
				else
					graphics.setColor(1, 0, 0)
					love.graphics.rectangle("fill", -500, 350, 1000, 25)
					graphics.setColor(0, 1, 0)
					love.graphics.rectangle("fill", 500, 350, -health * 10, 25)
					graphics.setColor(0, 0, 0)
					love.graphics.setLineWidth(10)
					love.graphics.rectangle("line", -500, 350, 1000, 25)
					love.graphics.setLineWidth(1)
					graphics.setColor(1, 1, 1)
				end
				
				boyfriendIcon:draw()
				enemyIcon:draw()
				
				if settings.downscroll then
					graphics.setColor(0, 0, 0)
					love.graphics.print("Score: " .. score, 300, -350)
					graphics.setColor(1, 1, 1)
				else
					graphics.setColor(0, 0, 0)
					love.graphics.print("Score: " .. score, 300, 400)
					graphics.setColor(1, 1, 1)
				end
			love.graphics.pop()
		end
	end,
	
	leave = function()
		walls = nil
		escalator = nil
		
		santa = nil
		
		weeks:leave()
	end
}
