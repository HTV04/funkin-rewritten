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

local animList = {
	"left",
	"down",
	"up",
	"right"
}
local inputList = {
	"gameLeft",
	"gameDown",
	"gameUp",
	"gameRight"
}

weeks = {
	init = function()
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
		
		sheets = {
			["icons"] = love.graphics.newImage(graphics.imagePath("icons")),
			["notes"] = love.graphics.newImage(graphics.imagePath("notes"))
		}
		
		sprites = {
			["icons"] = love.filesystem.load("sprites/icons.lua")
		}
		
		girlfriend = love.filesystem.load("sprites/girlfriend.lua")()
		boyfriend = love.filesystem.load("sprites/boyfriend.lua")()
		
		enemyIcon = sprites["icons"]()
		boyfriendIcon = sprites["icons"]()
		
		enemyIcon.y = 350
		enemyIcon.sizeX, enemyIcon.sizeY = 1.5, 1.5
		boyfriendIcon.y = 350
		boyfriendIcon.sizeX, boyfriendIcon.sizeY = -1.5, 1.5
		
		for i = 1, 3 do
			sounds["miss"][i]:setVolume(0.25)
		end
	end,
	
	load = function()
		gameOver = false
		cam.x, cam.y = -boyfriend.x + 100, -boyfriend.y + 50
		
		girlfriendFrameTimer = 0
		
		enemy:animate("idle")
		boyfriend:animate("idle")
		
		graphics.fadeIn(1)
	end,
	
	initUI = function()
		events = {}
		enemyNotes = {}
		boyfriendNotes = {}
		health = 50
		score = 0
		
		sprites["left arrow"] = love.filesystem.load("sprites/left-arrow.lua")
		sprites["down arrow"] = love.filesystem.load("sprites/down-arrow.lua")
		sprites["up arrow"] = love.filesystem.load("sprites/up-arrow.lua")
		sprites["right arrow"] = love.filesystem.load("sprites/right-arrow.lua")
		
		enemyArrows = {
			sprites["left arrow"](),
			sprites["down arrow"](),
			sprites["up arrow"](),
			sprites["right arrow"]()
		}
		boyfriendArrows= {
			sprites["left arrow"](),
			sprites["down arrow"](),
			sprites["up arrow"](),
			sprites["right arrow"]()
		}
		
		for i = 1, 4 do
			enemyArrows[i].x = -925 + 165 * i
			enemyArrows[i].y = -400
			boyfriendArrows[i].x = 100 + 165 * i
			boyfriendArrows[i].y = -400
			
			enemyNotes[i] = {}
			boyfriendNotes[i] = {}
		end
	end,
	
	generateNotes = function(chart)
		speed = chart.speed
		
		local bpm = 100
		
		for i = 1, #chart do
			local oldBpm = bpm
			
			bpm = chart[i].bpm
			
			if not bpm then
				bpm = oldBpm
			end
			
			for j = 1, #chart[i].sectionNotes do
				local sprite
				
				local mustHitSection = chart[i].mustHitSection
				local noteType = chart[i].sectionNotes[j].noteType
				local noteTime = chart[i].sectionNotes[j].noteTime
				
				if j == 1 then
					table.insert(events, {eventTime = chart[i].sectionNotes[1].noteTime, mustHitSection = mustHitSection, bpm = bpm})
				end
				
				if noteType == 0 or noteType == 4 then
					sprite = sprites["left arrow"]
				elseif noteType == 1 or noteType == 5 then 
					sprite = sprites["down arrow"]
				elseif noteType == 2 or noteType == 6 then 
					sprite = sprites["up arrow"]
				elseif noteType == 3 or noteType == 7 then 
					sprite = sprites["right arrow"]
				end
				
				if mustHitSection then
					if noteType >= 4 then
						local id = noteType - 3
						local c = #enemyNotes[id] + 1
						local x = enemyArrows[id].x
						
						table.insert(enemyNotes[id], sprite())
						enemyNotes[id][c].x = x
						enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
						enemyNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								local c = #enemyNotes[id] + 1
								
								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									enemyNotes[id][c].y = enemyNotes[id][c].y + 10
									
									enemyNotes[id][c]:animate("end", false)
								else
									enemyNotes[id][c]:animate("hold", false)
								end
							end
						end
					else
						local id = noteType + 1
						local c = #boyfriendNotes[id] + 1
						local x = boyfriendArrows[id].x
						
						table.insert(boyfriendNotes[id], sprite())
						boyfriendNotes[id][c].x = x
						boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
						boyfriendNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								local c = #boyfriendNotes[id] + 1
								
								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									boyfriendNotes[id][c].y = boyfriendNotes[id][c].y + 10
									
									boyfriendNotes[id][c]:animate("end", false)
								else
									boyfriendNotes[id][c]:animate("hold", false)
								end
							end
						end
					end
				else
					if noteType >= 4 then
						local id = noteType - 3
						local c = #boyfriendNotes[id] + 1
						local x = boyfriendArrows[id].x
						
						table.insert(boyfriendNotes[id], sprite())
						boyfriendNotes[id][c].x = x
						boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
						boyfriendNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								local c = #boyfriendNotes[id] + 1
								
								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									boyfriendNotes[id][c].y = boyfriendNotes[id][c].y + 10
									
									boyfriendNotes[id][c]:animate("end", false)
								else
									boyfriendNotes[id][c]:animate("hold", false)
								end
							end
						end
					else
						local id = noteType + 1
						local c = #enemyNotes[id] + 1
						local x = enemyArrows[id].x
						
						table.insert(enemyNotes[id], sprite())
						enemyNotes[id][c].x = x
						enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
						enemyNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								local c = #enemyNotes[id] + 1
								
								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									enemyNotes[id][c].y = enemyNotes[id][c].y + 10
									
									enemyNotes[id][c]:animate("end", false)
								else
									enemyNotes[id][c]:animate("hold", false)
								end
							end
						end
					end
				end
			end
			
			for i = 1, 4 do
				table.sort(enemyNotes[i], function(a, b) return a.y < b.y end)
				table.sort(boyfriendNotes[i], function(a, b) return a.y < b.y end)
			end
		end
	end,
	
	update = function(dt)
		oldMusicThres = musicThres
		
		musicTime = musicTime + (love.timer.getTime() * 1000) - previousFrameTime
		previousFrameTime = love.timer.getTime() * 1000
		
		if voices:tell("seconds") * 1000 ~= lastReportedPlaytime then
			musicTime = (musicTime + (voices:tell("seconds") * 1000)) / 2
			lastReportedPlaytime = voices:tell("seconds") * 1000
		end
		
		musicThres = math.floor(musicTime / 100) -- Since "musicTime" isn't precise, this is needed
		musicPos = musicTime * 0.6 * speed
		
		
		for i = 1, #events do
			if events[i].eventTime <= musicTime then
				if events[i].bpm then
					bpm = events[i].bpm
					
					girlfriend.anim.speed = 14.4 / (60 / bpm)
				end
				
				if camTimer then
					Timer.cancel(camTimer)
				end
				if events[i].mustHitSection then
					camTimer = Timer.tween(1.25, cam, {x = -boyfriend.x + 100, y = -boyfriend.y + 50}, "out-quad")
				else
					camTimer = Timer.tween(1.25, cam, {x = -enemy.x - 100, y = -enemy.y + 75}, "out-quad")
				end
				
				table.remove(events, i)
				
				break
			end
		end
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 240000 / bpm) < 100 then
			Timer.tween((60 / bpm) / 16, cam, {sizeX = camScale.x * 1.05, sizeY = camScale.y * 1.05}, "out-quad", function() Timer.tween((60 / bpm), cam, {sizeX = camScale.x, sizeY = camScale.y}, "out-quad") end)
		end
		
		girlfriend:update(dt)
		enemy:update(dt)
		boyfriend:update(dt)
		
		if girlfriendFrameTimer >= 29 then
			girlfriend:animate("idle", true)
			girlfriend.anim.speed = 14.4 / (60 / bpm)
			
			girlfriendFrameTimer = 0
		end
		girlfriendFrameTimer = girlfriendFrameTimer + 14.4 / (60 / bpm) * dt
		
		if boyfriendFrameTimer >= 13 then
			boyfriend:animate("idle", true)
			boyfriendFrameTimer = 0
		end
		boyfriendFrameTimer = boyfriendFrameTimer + 24 * dt
	end,
	
	updateUI = function(dt)
		for i = 1, 4 do
			local enemyArrow = enemyArrows[i]
			local boyfriendArrow = boyfriendArrows[i]
			local enemyNote = enemyNotes[i]
			local boyfriendNote = boyfriendNotes[i]
			local curAnim = animList[i]
			local curInput = inputList[i]
			
			enemyArrow:update(dt)
			boyfriendArrow:update(dt)
			
			if not enemyArrow.animated then
				enemyArrow:animate("off", false)
			end
			
			if #enemyNote > 0 then
				if enemyNote[1].y - musicTime * 0.6 * speed < -400 then
					if enemyNote[1].x == enemyArrow.x then
						voices:setVolume(1)
						
						enemyArrow:animate("confirm", false)
						
						enemy:animate(curAnim, false)
						enemyFrameTimer = 0
						
						table.remove(enemyNote, 1)
					end
				end
			end
			
			if #boyfriendNote > 0 then
				if boyfriendNote[1].y - musicPos < -500 then
					if inst then
						voices:setVolume(0)
					end
					
					table.remove(boyfriendNote, 1)
					
					health = health - 2
				end
			end
			
			if input:pressed(curInput) then
				local success = false
				
				if settings.kadeInput then
					success = true
				end
				
				boyfriendArrow:animate("press", false)
				
				if #boyfriendNote > 0 then
					local musicPos = musicTime * 0.6 * speed
					
					for i = 1, #boyfriendNote do
						if boyfriendNote[i] and boyfriendNote[i].anim.name == "on" and boyfriendNote[i].x == boyfriendArrow.x and boyfriendNote[i].y - musicPos <= -260 then
							local notePos = math.abs(-400 - (boyfriendNote[i].y - musicPos))
							
							voices:setVolume(1)
							
							if notePos <= 30 then -- "Sick"
								score = score + 350
							elseif notePos <= 70 then -- "Good"
								score = score + 200
							elseif notePos <= 110 then -- "Bad"
								score = score + 100
							else -- "Shit"
								if settings.kadeInput then
									success = false
								else
									score = score + 50
								end
							end
							
							table.remove(boyfriendNote, i)
							
							if not settings.kadeInput or success then
								boyfriendArrow:animate("confirm", false)
								
								boyfriend:animate(curAnim, false)
								boyfriendFrameTimer = 0
								
								health = health + 1
								
								success = true
							end
							
							break
						end
					end
				end
				
				if not success then
					audio.playSound(sounds["miss"][love.math.random(3)])
					
					boyfriend:animate("miss " .. curAnim, false)
					boyfriendFrameTimer = 0
					
					health = health - 2
					score = score - 10
				end
			end
			
			if #boyfriendNote > 0 then
				if input:down(curInput) then
					if boyfriendNote[1].y - musicPos <= -400 and (boyfriendNote[1].anim.name == "hold" or boyfriendNote[1].anim.name == "end") then
						voices:setVolume(1)
						
						table.remove(boyfriendNote, 1)
						
						boyfriendArrow:animate("confirm", false)
						
						boyfriend:animate(curAnim, false)
						boyfriendFrameTimer = 0
						
						health = health + 1
					end
				end
			end
			
			if input:released(curInput) then
				boyfriendArrow:animate("off", false)
			end
		end
		
		if health > 100 then
			health = 100
		elseif health > 20 and boyfriendIcon.anim.name == "boyfriend losing" then
			boyfriendIcon:animate("boyfriend", false)
		elseif health <= 0 then -- Game over, yeah!
			if inst then
				inst:stop()
			end
			voices:stop()
			
			gameOver = true
			
			audio.playSound(sounds["death"])
			
			if fakeBoyfriend then
				fakeBoyfriend:animate("dies", false)
			else
				boyfriend:animate("dies", false)
			end
			
			Timer.clear()
			Timer.tween(
				2,
				cam,
				{x = -boyfriend.x, y = -boyfriend.y, sizeX = camScale.x, sizeY = camScale.y},
				"out-quad",
				function()
					inst = love.audio.newSource("music/game-over.ogg", "stream")
					inst:setLooping(true)
					inst:play()
					
					if fakeBoyfriend then
						fakeBoyfriend:animate("dead", true)
					else
						boyfriend:animate("dead", true)
					end
				end
			)
		elseif health <= 20 and boyfriendIcon.anim.name == "boyfriend" then
			boyfriendIcon:animate("boyfriend losing", false)
		end
		
		enemyIcon.x = 425 - health * 10
		boyfriendIcon.x = 585 - health * 10
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 60000 / bpm) < 100 then
			Timer.tween((60 / bpm) / 16, enemyIcon, {sizeX = 1.75, sizeY = 1.75}, "out-quad", function() Timer.tween((60 / bpm), enemyIcon, {sizeX = 1.5, sizeY = 1.5}, "out-quad") end)
			Timer.tween((60 / bpm) / 16, boyfriendIcon, {sizeX = -1.75, sizeY = 1.75}, "out-quad", function() Timer.tween((60 / bpm), boyfriendIcon, {sizeX = -1.5, sizeY = 1.5}, "out-quad") end)
		end
		
		if input:pressed("gameBack") then
			if inst then
				inst:stop()
			end
			voices:stop()
			
			storyMode = false
		end
	end,
	
	voicesPlay = function()
		previousFrameTime = love.timer.getTime() * 1000
		lastReportedPlaytime = 0
		musicTime = 0
		
		musicThres = 0
		musicPos = 0
		
		voices:play()
	end,
	
	draw = function()
		if not inGame then return end
		
		if gameOver then
			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
				love.graphics.translate(cam.x, cam.y)
				
				if fakeBoyfriend then
					fakeBoyfriend:draw()
				else
					boyfriend:draw()
				end
			love.graphics.pop()
			
			return
		end
	end,
	
	drawUI = function()
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
					if enemyNotes[i][j].y - musicPos <= 560 then
						local animName = enemyNotes[i][j].anim.name
						
						if animName == "hold" or animName == "end" then
							graphics.setColor(1, 1, 1, 0.5)
						end
						enemyNotes[i][j]:draw()
						graphics.setColor(1, 1, 1)
					end
				end
				for j = #boyfriendNotes[i], 1, -1 do
					if boyfriendNotes[i][j].y - musicPos <= 560 then
						local animName = boyfriendNotes[i][j].anim.name
						
						if animName == "hold" or animName == "end" then
							graphics.setColor(1, 1, 1, 0.5)
						end
						boyfriendNotes[i][j]:draw()
						graphics.setColor(1, 1, 1)
					end
				end
			love.graphics.pop()
		end
		
		graphics.setColor(1, 0, 0)
		love.graphics.rectangle("fill", -500, 350, 1000, 25)
		graphics.setColor(0, 1, 0)
		love.graphics.rectangle("fill", 500, 350, -health * 10, 25)
		graphics.setColor(0, 0, 0)
		love.graphics.setLineWidth(10)
		love.graphics.rectangle("line", -500, 350, 1000, 25)
		love.graphics.setLineWidth(1)
		graphics.setColor(1, 1, 1)
		
		boyfriendIcon:draw()
		enemyIcon:draw()
		
		love.graphics.print("Score: " .. score, 300, 400)
	end,
	
	stop = function()
		if inst then
			inst:stop()
		end
		voices:stop()
		
		Timer.clear()
		
		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9
		
		menu.load()
		
		graphics.fadeIn(0.5)
	end
}
