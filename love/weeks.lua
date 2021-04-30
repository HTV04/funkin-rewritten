--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

weeks = {
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
		cam.x, cam.y = -boyfriend.x + 50, -boyfriend.y + 50
		
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
		
		sheets["notes"] = love.graphics.newImage("images/NOTE_assets.png")
		
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
				local x
				
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
						x = enemyArrows[1].x + 165 * (noteType - 4)
						
						table.insert(enemyNotes, sprite())
						enemyNotes[#enemyNotes].x = x
						enemyNotes[#enemyNotes].y = -400 + noteTime * 0.6 * speed
						enemyNotes[#enemyNotes]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								table.insert(enemyNotes, sprite())
								enemyNotes[#enemyNotes].x = x
								enemyNotes[#enemyNotes].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									enemyNotes[#enemyNotes].y = enemyNotes[#enemyNotes].y + 10
									
									enemyNotes[#enemyNotes]:animate("end", false)
								else
									enemyNotes[#enemyNotes]:animate("hold", false)
								end
							end
						end
					else
						x = boyfriendArrows[1].x + 165 * noteType
						
						table.insert(boyfriendNotes, sprite())
						boyfriendNotes[#boyfriendNotes].x = x
						boyfriendNotes[#boyfriendNotes].y = -400 + noteTime * 0.6 * speed
						boyfriendNotes[#boyfriendNotes]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								table.insert(boyfriendNotes, sprite())
								boyfriendNotes[#boyfriendNotes].x = x
								boyfriendNotes[#boyfriendNotes].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									boyfriendNotes[#boyfriendNotes].y = boyfriendNotes[#boyfriendNotes].y + 10
									
									boyfriendNotes[#boyfriendNotes]:animate("end", false)
								else
									boyfriendNotes[#boyfriendNotes]:animate("hold", false)
								end
							end
						end
					end
				else
					if noteType >= 4 then
						x = boyfriendArrows[1].x + 165 * (noteType - 4)
						
						table.insert(boyfriendNotes, sprite())
						boyfriendNotes[#boyfriendNotes].x = x
						boyfriendNotes[#boyfriendNotes].y = -400 + noteTime * 0.6 * speed
						boyfriendNotes[#boyfriendNotes]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								table.insert(boyfriendNotes, sprite())
								boyfriendNotes[#boyfriendNotes].x = x
								boyfriendNotes[#boyfriendNotes].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									boyfriendNotes[#boyfriendNotes].y = boyfriendNotes[#boyfriendNotes].y + 10
									
									boyfriendNotes[#boyfriendNotes]:animate("end", false)
								else
									boyfriendNotes[#boyfriendNotes]:animate("hold", false)
								end
							end
						end
					else
						x = enemyArrows[1].x + 165 * noteType
						
						table.insert(enemyNotes, sprite())
						enemyNotes[#enemyNotes].x = x
						enemyNotes[#enemyNotes].y = -400 + noteTime * 0.6 * speed
						enemyNotes[#enemyNotes]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 71 / speed, chart[i].sectionNotes[j].noteLength, 71 / speed do
								table.insert(enemyNotes, sprite())
								enemyNotes[#enemyNotes].x = x
								enemyNotes[#enemyNotes].y = -400 + (noteTime + k) * 0.6 * speed
								if k > chart[i].sectionNotes[j].noteLength - 71 / speed then
									enemyNotes[#enemyNotes].y = enemyNotes[#enemyNotes].y + 10
									
									enemyNotes[#enemyNotes]:animate("end", false)
								else
									enemyNotes[#enemyNotes]:animate("hold", false)
								end
							end
						end
					end
				end
			end
			
			table.sort(enemyNotes, function(a,b) return a.y < b.y end)
			table.sort(boyfriendNotes, function(a,b) return a.y < b.y end)
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
					camTimer = Timer.tween(1.25, cam, {x = -boyfriend.x + 50, y = -boyfriend.y + 50}, "out-quad")
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
			enemyArrows[i]:update(dt)
			boyfriendArrows[i]:update(dt)
		end
		
		for i = 1, 4 do
			if not enemyArrows[i].animated then
				enemyArrows[i]:animate("off", false)
			end
		end
		
		for i = 1, #enemyNotes do
			enemyNotes[i].offsetY = musicTime * 0.6 * speed
		end
		for	i = 1, #enemyNotes do
			if enemyNotes[1].y - enemyNotes[1].offsetY < -400 then
				if enemyNotes[1].x == enemyArrows[1].x then
					voices:setVolume(1)
					
					enemyArrows[1]:animate("confirm", false)
					
					enemy:animate("left", false)
					enemyFrameTimer = 0
				elseif enemyNotes[1].x == enemyArrows[2].x then
					voices:setVolume(1)
					
					enemyArrows[2]:animate("confirm", false)
					
					enemy:animate("down", false)
					enemyFrameTimer = 0
				elseif enemyNotes[1].x == enemyArrows[3].x then
					voices:setVolume(1)
					
					enemyArrows[3]:animate("confirm", false)
					
					enemy:animate("up", false)
					enemyFrameTimer = 0
				elseif enemyNotes[1].x == enemyArrows[4].x then
					voices:setVolume(1)
					
					enemyArrows[4]:animate("confirm", false)
					
					enemy:animate("right", false)
					enemyFrameTimer = 0
				end
				
				table.remove(enemyNotes, 1)
			else
				break
			end
		end
		
		for i = 1, #boyfriendNotes do
			boyfriendNotes[i].offsetY = musicTime * 0.6 * speed
		end
		for i = 1, #boyfriendNotes do
			if boyfriendNotes[1].y - boyfriendNotes[1].offsetY < -500 then
				if inst then
					voices:setVolume(0)
				end
				
				table.remove(boyfriendNotes, 1)
				
				health = health - 2
			else
				break
			end
		end
		
		if input:pressed("gameLeft") then
			local success = false
			
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[1].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -250 then
					if boyfriendNotes[i].anim.name == "on" then
						voices:setVolume(1)
						
						if math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 37 then -- "Sick"
							score = score + 350
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 75 then -- "Good"
							score = score + 200
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 112 then -- "Bad"
							score = score + 100
						else -- "Shit"
							score = score + 50
						end
						
						table.remove(boyfriendNotes, i)
						
						boyfriendArrows[1]:animate("confirm", false)
						
						boyfriend:animate("left", false)
						boyfriendFrameTimer = 0
						
						health = health + 1
					end
					
					success = true
					
					break
				end
			end
			
			if not success then
				audio.playSound(sounds["miss"][love.math.random(3)])
				
				boyfriendArrows[1]:animate("press", false)
				
				boyfriend:animate("miss left", false)
				boyfriendFrameTimer = 0
				
				health = health - 2
				score = score - 10
			end
		end
		if input:pressed("gameDown") then
			local success = false
			
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[2].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -300 then
					if boyfriendNotes[i].anim.name == "on" then
						voices:setVolume(1)
						
						if math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 37 then -- "Sick"
							score = score + 350
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 75 then -- "Good"
							score = score + 200
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 112 then -- "Bad"
							score = score + 100
						else -- "Shit"
							score = score + 50
						end
						
						table.remove(boyfriendNotes, i)
						
						boyfriendArrows[2]:animate("confirm", false)
						
						boyfriend:animate("down", false)
						boyfriendFrameTimer = 0
						
						health = health + 1
					end
					
					success = true
					
					break
				end
			end
			
			if not success then
				audio.playSound(sounds["miss"][love.math.random(3)])
				
				boyfriendArrows[2]:animate("press", false)
				
				boyfriend:animate("miss down", false)
				boyfriendFrameTimer = 0
				
				health = health - 2
				score = score - 10
			end
		end
		if input:pressed("gameUp") then
			local success = false
			
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[3].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -250 then
					if boyfriendNotes[i].anim.name == "on" then
						voices:setVolume(1)
						
						if math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 37 then -- "Sick"
							score = score + 350
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 75 then -- "Good"
							score = score + 200
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 112 then -- "Bad"
							score = score + 100
						else -- "Shit"
							score = score + 50
						end
						
						table.remove(boyfriendNotes, i)
						
						boyfriendArrows[3]:animate("confirm", false)
						
						boyfriend:animate("up", false)
						boyfriendFrameTimer = 0
						
						health = health + 1
					end
					
					success = true
					
					break
				end
			end
			
			if not success then
				audio.playSound(sounds["miss"][love.math.random(3)])
				
				boyfriendArrows[3]:animate("press", false)
				
				boyfriend:animate("miss up", false)
				boyfriendFrameTimer = 0
				
				health = health - 2
				score = score - 10
			end
		end
		if input:pressed("gameRight") then
			local success = false
			
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[4].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -250 then
					if boyfriendNotes[i].anim.name == "on" then
						voices:setVolume(1)
						
						if math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 37 then -- "Sick"
							score = score + 350
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 75 then -- "Good"
							score = score + 200
						elseif math.abs(-400 - boyfriendNotes[i].y - boyfriendNotes[i].offsetY) >= 112 then -- "Bad"
							score = score + 100
						else -- "Shit"
							score = score + 50
						end
						
						table.remove(boyfriendNotes, i)
						
						boyfriendArrows[4]:animate("confirm", false)
						
						boyfriend:animate("right", false)
						boyfriendFrameTimer = 0
						
						health = health + 1
					end
					
					success = true
					
					break
				end
			end
			
			if not success then
				audio.playSound(sounds["miss"][love.math.random(3)])
				
				boyfriendArrows[4]:animate("press", false)
				
				boyfriend:animate("miss right", false)
				boyfriendFrameTimer = 0
				
				health = health - 2
				score = score - 10
			end
		end
		
		if input:down("gameLeft") then
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[1].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -400 and (boyfriendNotes[i].anim.name == "hold" or boyfriendNotes[i].anim.name == "end") then
					voices:setVolume(1)
					
					table.remove(boyfriendNotes, i)
					
					boyfriendArrows[1]:animate("confirm", false)
					
					boyfriend:animate("left", false)
					boyfriendFrameTimer = 0
					
					health = health + 1
					
					break
				end
			end
		end
		if input:down("gameDown") then
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[2].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -400 and (boyfriendNotes[i].anim.name == "hold" or boyfriendNotes[i].anim.name == "end") then
					voices:setVolume(1)
					
					table.remove(boyfriendNotes, i)
					
					boyfriendArrows[2]:animate("confirm", false)
					
					boyfriend:animate("down", false)
					boyfriendFrameTimer = 0
					
					health = health + 1
					
					break
				end
			end
		end
		if input:down("gameUp") then
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[3].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -400 and (boyfriendNotes[i].anim.name == "hold" or boyfriendNotes[i].anim.name == "end") then
					voices:setVolume(1)
					
					table.remove(boyfriendNotes, i)
					
					boyfriendArrows[3]:animate("confirm", false)
					
					boyfriend:animate("up", false)
					boyfriendFrameTimer = 0
					
					health = health + 1
					
					break
				end
			end
		end
		if input:down("gameRight") then
			for i = 1, math.min(4, #boyfriendNotes) do
				if boyfriendNotes[i].x == boyfriendArrows[4].x and boyfriendNotes[i].y - boyfriendNotes[i].offsetY <= -400 and (boyfriendNotes[i].anim.name == "hold" or boyfriendNotes[i].anim.name == "end") then
					voices:setVolume(1)
					
					table.remove(boyfriendNotes, i)
					
					boyfriendArrows[4]:animate("confirm", false)
					
					boyfriend:animate("right", false)
					boyfriendFrameTimer = 0
					
					health = health + 1
					
					break
				end
			end
		end
		
		if input:released("gameLeft") then
			boyfriendArrows[1]:animate("off", false)
		end
		if input:released("gameDown") then
			boyfriendArrows[2]:animate("off", false)
		end
		if input:released("gameUp") then
			boyfriendArrows[3]:animate("off", false)
		end
		if input:released("gameRight") then
			boyfriendArrows[4]:animate("off", false)
		end
		
		if health > 100 then
			health = 100
		elseif health > 20 then
			if boyfriendIcon.anim.name == "boyfriend losing" then
				boyfriendIcon:animate("boyfriend", false)
			end
		elseif health <= 0 then -- Game over, yeah!
			if inst then
				inst:stop()
			end
			voices:stop()
			
			gameOver = true
			
			audio.playSound(sounds["death"])
			
			boyfriend:animate("dies", false)
			
			Timer.clear()
			Timer.tween(
				2,
				cam,
				{x = -boyfriend.x, y = -boyfriend.y, sizeX = camScale.x, sizeY = camScale.y},
				"out-quad",
				function()
					inst = love.audio.newSource("music/gameOver.ogg", "stream")
					inst:setLooping(true)
					inst:play()
					
					boyfriend:animate("dead", true)
				end
			)
		elseif health <= 20 then
			if boyfriendIcon.anim.name == "boyfriend" then
				boyfriendIcon:animate("boyfriend losing", false)
			end
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
		musicThres = 0
		previousFrameTime = love.timer.getTime() * 1000
		lastReportedPlaytime = 0
		musicTime = 0
		
		voices:play()
	end,
	
	draw = function()
		if not inGame then return end
		
		if gameOver then
			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
				love.graphics.translate(cam.x, cam.y)
				
				boyfriend:draw()
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
		end
		
		for i = #enemyNotes, 1, -1 do
			if enemyNotes[i].y - enemyNotes[i].offsetY < 560 then
				local animName = enemyNotes[i].anim.name
				
				if animName == "hold" or animName == "end" then
					graphics.setColor(1, 1, 1, 0.5)
				end
			
				enemyNotes[i]:draw()
				
				graphics.setColor(1, 1, 1)
			end
		end
		for i = #boyfriendNotes, 1, -1 do
			if boyfriendNotes[i].y - boyfriendNotes[i].offsetY < 560 then
				local animName = boyfriendNotes[i].anim.name
				
				if animName == "hold" or animName == "end" then
					graphics.setColor(1, 1, 1, 0.5)
				end
				
				boyfriendNotes[i]:draw()
				
				graphics.setColor(1, 1, 1)
			end
		end
		
		graphics.setColor(1, 0, 0)
			love.graphics.rectangle("fill", -500, 350, 1000, 30)
		graphics.setColor(0, 1, 0)
			love.graphics.rectangle("fill", 500, 350, -health * 10, 30)
		graphics.setColor(0, 0, 0)
			love.graphics.setLineWidth(10)
				love.graphics.rectangle("line", -500, 350, 1000, 30)
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
		
		inMenu = true
		songNum = 0
		
		storyMode = false
		inGame = false
		
		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9
		
		menuState = 0
		
		graphics.fadeIn(0.5)
		
		music:play()
	end
}
