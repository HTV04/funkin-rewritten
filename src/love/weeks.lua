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

local useAltAnims

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

local ratingTimers = {}

return {
	enter = function(self)
		useAltAnims = false
		
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
		
		girlfriend = love.filesystem.load("sprites/girlfriend.lua")()
		boyfriend = love.filesystem.load("sprites/boyfriend.lua")()
		
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
		
		for i = 1, 3 do
			sounds["miss"][i]:setVolume(0.25)
		end
	end,
	
	load = function(self)
		gameOver = false
		
		cam.x, cam.y = -boyfriend.x + 100, -boyfriend.y + 75
		
		rating.x = girlfriend.x
		for i = 1, 3 do
			numbers[i].x = girlfriend.x - 100 + 50 * i
		end
		
		ratingVisibility = {0}
		combo = 0
		
		enemy:animate("idle")
		boyfriend:animate("idle")
		
		graphics.fadeIn(0.5)
	end,
	
	initUI = function(self)
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
			boyfriendArrows[i].x = 100 + 165 * i
			if settings.downscroll then
				enemyArrows[i].y = 400
				boyfriendArrows[i].y = 400
			else
				enemyArrows[i].y = -400
				boyfriendArrows[i].y = -400
			end
			
			enemyNotes[i] = {}
			boyfriendNotes[i] = {}
		end
	end,
	
	generateNotes = function(self, chart)
		local eventBpm
		
		for i = 1, #chart do
			bpm = chart[i].bpm
			
			if bpm then
				break
			end
		end
		if not bpm then
			bpm = 100
		end
		
		speed = chart.speed
		
		for i = 1, #chart do
			eventBpm = chart[i].bpm
			
			for j = 1, #chart[i].sectionNotes do
				local sprite
				
				local mustHitSection = chart[i].mustHitSection
				local altAnim = chart[i].altAnim
				local noteType = chart[i].sectionNotes[j].noteType
				local noteTime = chart[i].sectionNotes[j].noteTime
				
				if j == 1 then
					table.insert(events, {eventTime = chart[i].sectionNotes[1].noteTime, mustHitSection = mustHitSection, bpm = eventBpm, altAnim = altAnim})
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
				
				if settings.downscroll then
					if mustHitSection then
						if noteType >= 4 then
							local id = noteType - 3
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x
							
							table.insert(enemyNotes[id], sprite())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = 400 - noteTime * 0.6 * speed
							enemyNotes[id][c]:animate("on", false)
							if chart[i].sectionNotes[j].noteLength > 0 then
								for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
									local c = #enemyNotes[id] + 1
									
									table.insert(enemyNotes[id], sprite())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed
									if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
										enemyNotes[id][c].y = enemyNotes[id][c].y - 11
										enemyNotes[id][c].orientation = math.pi
										
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
							boyfriendNotes[id][c].y = 400 - noteTime * 0.6 * speed
							boyfriendNotes[id][c]:animate("on", false)
							if chart[i].sectionNotes[j].noteLength > 0 then
								for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
									local c = #boyfriendNotes[id] + 1
									
									table.insert(boyfriendNotes[id], sprite())
									boyfriendNotes[id][c].x = x
									boyfriendNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed
									if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
										boyfriendNotes[id][c].y = boyfriendNotes[id][c].y - 11
										boyfriendNotes[id][c].orientation = math.pi
										
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
							boyfriendNotes[id][c].y = 400 - noteTime * 0.6 * speed
							boyfriendNotes[id][c]:animate("on", false)
							if chart[i].sectionNotes[j].noteLength > 0 then
								for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
									local c = #boyfriendNotes[id] + 1
									
									table.insert(boyfriendNotes[id], sprite())
									boyfriendNotes[id][c].x = x
									boyfriendNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed
									if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
										boyfriendNotes[id][c].y = boyfriendNotes[id][c].y - 11
										boyfriendNotes[id][c].orientation = math.pi
										
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
							enemyNotes[id][c].y = 400 - noteTime * 0.6 * speed
							enemyNotes[id][c]:animate("on", false)
							if chart[i].sectionNotes[j].noteLength > 0 then
								for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
									local c = #enemyNotes[id] + 1
									
									table.insert(enemyNotes[id], sprite())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = 400 - (noteTime + k) * 0.6 * speed
									if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
										enemyNotes[id][c].y = enemyNotes[id][c].y - 11
										enemyNotes[id][c].orientation = math.pi
										
										enemyNotes[id][c]:animate("end", false)
									else
										enemyNotes[id][c]:animate("hold", false)
									end
								end
							end
						end
					end
				else
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
			end
		end
		
		if settings.downscroll then
			for i = 1, 4 do
				table.sort(enemyNotes[i], function(a, b) return a.y > b.y end)
				table.sort(boyfriendNotes[i], function(a, b) return a.y > b.y end)
			end
		else
			for i = 1, 4 do
				table.sort(enemyNotes[i], function(a, b) return a.y < b.y end)
				table.sort(boyfriendNotes[i], function(a, b) return a.y < b.y end)
			end
		end
		
		-- Workarounds for bad charts that have multiple notes around the same place
		for i = 1, 4 do
			local offset = 0
			
			for j = 2, #enemyNotes[i] do
				local index = j - offset
				
				if enemyNotes[i][index].anim.name == "on" and enemyNotes[i][index - 1].anim.name == "on" and ((not settings.downscroll and enemyNotes[i][index].y - enemyNotes[i][index - 1].y <= 10) or (settings.downscroll and enemyNotes[i][index].y - enemyNotes[i][index - 1].y >= -10)) then
					table.remove(enemyNotes[i], index)
					
					offset = offset + 1
				end
			end
		end
		for i = 1, 4 do
			local offset = 0
			
			for j = 2, #boyfriendNotes[i] do
				local index = j - offset
				
				if boyfriendNotes[i][index].anim.name == "on" and boyfriendNotes[i][index - 1].anim.name == "on" and ((not settings.downscroll and boyfriendNotes[i][index].y - boyfriendNotes[i][index - 1].y <= 10) or (settings.downscroll and boyfriendNotes[i][index].y - boyfriendNotes[i][index - 1].y >= -10)) then
					table.remove(boyfriendNotes[i], index)
					
					offset = offset + 1
				end
			end
		end
	end,
	
	voicesPlay = function(self)
		previousFrameTime = love.timer.getTime() * 1000
		lastReportedPlaytime = 0
		musicTime = 0
		
		musicThres = 0
		musicPos = 0
		
		voices:play()
	end,
	
	safeAnimate = function(self, sprite, anim, loopAnim, timerID)
		sprite:animate(anim, loopAnim)
		
		spriteTimers[timerID] = 12
	end,
	
	update = function(self, dt)
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
					camTimer = Timer.tween(1.25, cam, {x = -boyfriend.x + 100, y = -boyfriend.y + 75}, "out-quad")
				else
					camTimer = Timer.tween(1.25, cam, {x = -enemy.x - 100, y = -enemy.y + 75}, "out-quad")
				end
				
				if events[i].altAnim then
					useAltAnims = true
				else
					useAltAnims = false
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
		enemy:update(dt)
		boyfriend:update(dt)
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 120000 / bpm) < 100 then
			if spriteTimers[1] == 0 then
				girlfriend:animate("idle", false)
				
				girlfriend.anim.speed = 14.4 / (60 / bpm)
			end
			if spriteTimers[2] == 0 then
				weeks:safeAnimate(enemy, "idle", false, 2)
			end
			if spriteTimers[3] == 0 then
				weeks:safeAnimate(boyfriend, "idle", false, 3)
			end
		end
		
		for i = 1, 3 do
			local spriteTimer = spriteTimers[i]
			
			if spriteTimer > 0 then
				spriteTimers[i] = spriteTimer - 1
			end
		end
	end,
	
	updateUI = function(self, dt)
		if settings.downscroll then
			musicPos = -musicTime * 0.6 * speed
		else	
			musicPos = musicTime * 0.6 * speed
		end
		
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
				if (not settings.downscroll and enemyNote[1].y - musicPos <= -400) or (settings.downscroll and enemyNote[1].y - musicPos >= 400) then
					voices:setVolume(1)
					
					enemyArrow:animate("confirm", false)
					
					if useAltAnims then
						weeks:safeAnimate(enemy, curAnim .. " alt", false, 2)
					else
						weeks:safeAnimate(enemy, curAnim, false, 2)
					end
					
					table.remove(enemyNote, 1)
				end
			end
			
			if #boyfriendNote > 0 then
				if (not settings.downscroll and boyfriendNote[1].y - musicPos < -500) or (settings.downscroll and boyfriendNote[1].y - musicPos > 500) then
					if inst then
						voices:setVolume(0)
					end
					
					table.remove(boyfriendNote, 1)
					
					if combo >= 5 then weeks:safeAnimate(girlfriend, "sad", true, 1) end
					
					combo = 0
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
					for i = 1, #boyfriendNote do
						if boyfriendNote[i] and boyfriendNote[i].anim.name == "on" then
							if (not settings.downscroll and boyfriendNote[i].y - musicPos <= -280) or (settings.downscroll and boyfriendNote[i].y - musicPos >= 280) then
								local notePos
								local ratingAnim
								
								if settings.downscroll then
									notePos = math.abs(400 - (boyfriendNote[i].y - musicPos))
								else
									notePos = math.abs(-400 - (boyfriendNote[i].y - musicPos))
								end
								
								voices:setVolume(1)
								
								if notePos <= 30 then -- "Sick"
									score = score + 350
									ratingAnim = "sick"
								elseif notePos <= 70 then -- "Good"
									score = score + 200
									ratingAnim = "good"
								elseif notePos <= 90 then -- "Bad"
									score = score + 100
									ratingAnim = "bad"
								else -- "Shit"
									if settings.kadeInput then
										success = false
									else
										score = score + 50
									end
									ratingAnim = "shit"
								end
								combo = combo + 1
								
								rating:animate(ratingAnim, false)
								numbers[1]:animate(tostring(math.floor(combo / 100 % 10), false))
								numbers[2]:animate(tostring(math.floor(combo / 10 % 10), false))
								numbers[3]:animate(tostring(math.floor(combo % 10), false))
								
								for i = 1, 5 do
									if ratingTimers[i] then Timer.cancel(ratingTimers[i]) end
								end
								
								ratingVisibility[1] = 1
								rating.y = girlfriend.y - 50
								for i = 1, 3 do
									numbers[i].y = girlfriend.y + 50
								end
								
								ratingTimers[1] = Timer.tween(2, ratingVisibility, {0})
								ratingTimers[2] = Timer.tween(2, rating, {y = girlfriend.y - 100}, "out-elastic")
								ratingTimers[3] = Timer.tween(2, numbers[1], {y = girlfriend.y + love.math.random(-10, 10)}, "out-elastic")
								ratingTimers[4] = Timer.tween(2, numbers[2], {y = girlfriend.y + love.math.random(-10, 10)}, "out-elastic")
								ratingTimers[5] = Timer.tween(2, numbers[3], {y = girlfriend.y + love.math.random(-10, 10)}, "out-elastic")
								
								table.remove(boyfriendNote, i)
								
								if not settings.kadeInput or success then
									boyfriendArrow:animate("confirm", false)
									
									weeks:safeAnimate(boyfriend, curAnim, false, 3)
									
									health = health + 1
									
									success = true
								end
							else
								break
							end
						end
					end
				end
				
				if not success then
					audio.playSound(sounds["miss"][love.math.random(3)])
					
					if combo >= 5 then weeks:safeAnimate(girlfriend, "sad", true, 1) end
					
					weeks:safeAnimate(boyfriend, "miss " .. curAnim, false, 3)
					
					score = score - 10
					combo = 0
					health = health - 2
				end
			end
			
			if #boyfriendNote > 0 then
				if input:down(curInput) then
					if ((not settings.downscroll and boyfriendNote[1].y - musicPos <= -400) or (settings.downscroll and boyfriendNote[1].y - musicPos >= 400)) and (boyfriendNote[1].anim.name == "hold" or boyfriendNote[1].anim.name == "end") then
						voices:setVolume(1)
						
						table.remove(boyfriendNote, 1)
						
						boyfriendArrow:animate("confirm", false)
						
						weeks:safeAnimate(boyfriend, curAnim, true, 3)
						
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
		elseif health <= 0 then -- Game over
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
			if enemyIconTimer then Timer.cancel(enemyIconTimer) end
			if boyfriendIconTimer then Timer.cancel(boyfriendIconTimer) end
			
			enemyIconTimer = Timer.tween((60 / bpm) / 16, enemyIcon, {sizeX = 1.75, sizeY = 1.75}, "out-quad", function() enemyIconTimer = Timer.tween((60 / bpm), enemyIcon, {sizeX = 1.5, sizeY = 1.5}, "out-quad") end)
			boyfriendIconTimer = Timer.tween((60 / bpm) / 16, boyfriendIcon, {sizeX = -1.75, sizeY = 1.75}, "out-quad", function() boyfriendIconTimer = Timer.tween((60 / bpm), boyfriendIcon, {sizeX = -1.5, sizeY = 1.5}, "out-quad") end)
		end
		
		if input:pressed("gameBack") then
			if inst then
				inst:stop()
			end
			voices:stop()
			
			storyMode = false
		end
	end,
	
	draw = function(self)
		if gameOver then
			love.graphics.push()
				love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
				
				love.graphics.push()
					love.graphics.scale(cam.sizeX, cam.sizeY)
					love.graphics.translate(cam.x, cam.y)
					
					if fakeBoyfriend then
						fakeBoyfriend:draw()
					else
						boyfriend:draw()
					end
				love.graphics.pop()
			love.graphics.pop()
		end
	end,
	
	drawRating = function(self, multiplier)
		love.graphics.push()
			love.graphics.translate(cam.x * multiplier, cam.y * multiplier)
			
			graphics.setColor(1, 1, 1, ratingVisibility[1])
			rating:draw()
			for i = 1, 3 do
				numbers[i]:draw()
			end
			graphics.setColor(1, 1, 1)
		love.graphics.pop()
	end,
	
	drawUI = function(self)
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
				love.graphics.print("Score: " .. score, 300, -350)
			else
				love.graphics.print("Score: " .. score, 300, 400)
			end
		love.graphics.pop()
	end,
	
	leave = function(self)
		if inst then
			inst:stop()
		end
		voices:stop()
		
		Timer.clear()
		
		fakeBoyfriend = nil
	end
}
