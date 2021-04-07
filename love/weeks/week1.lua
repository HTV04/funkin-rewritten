--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

week1 = {
	init = function()
		weeks.init()
		
		sheets["daddy dearest"] = love.graphics.newImage("images/DADDY_DEAREST.png")
		
		stageBack = Image("images/stageback.png")
		stageFront = Image("images/stagefront.png")
		curtains = Image("images/stagecurtains.png")
		
		stageFront.y = 400
		curtains.y = -100
		
		enemy = love.filesystem.load("sprites/daddy-dearest.lua")()
		
		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, -110
		boyfriend.x, boyfriend.y = 260, 100
		
		enemyIcon:animate("daddy dearest", false)
		
		week1.load()
	end,
	
	load = function()
		weeks.load()
		
		if songNum == 3 then
			inst = love.audio.newSource("music/Dadbattle_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Dadbattle_Voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/Fresh_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Fresh_Voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/Bopeebo_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Bopeebo_Voices.ogg", "stream")
		end
		
		week1.initUI()
		
		inst:play()
		weeks.voicesPlay()
	end,
	
	initUI = function()
		weeks.initUI()
		
		if songNum == 2 then
			chart = love.filesystem.load("charts/fresh" .. songAppend .. ".lua")()
		elseif songNum == 3 then
			chart = love.filesystem.load("charts/dadbattle" .. songAppend .. ".lua")()
		else
			chart = love.filesystem.load("charts/bopeebo" .. songAppend .. ".lua")()
		end
		
		weeks.generateNotes(chart)
	end,
	
	update = function(dt)
		if gameOver then
			if graphics.fade[1] == 1 and input:pressed("confirm") then
				inst:stop()
				inst = love.audio.newSource("music/gameOverEnd.ogg", "stream")
				inst:play()
				
				Timer.clear()
				
				cam.x, cam.y = -boyfriend.x, -boyfriend.y
				
				boyfriend:animate("dead confirm", false)
				
				graphics.fadeOut(3, week1.load)
			elseif input:pressed("gameBack") then
				graphics.fadeOut(1, week1.stop)
			end
			
			boyfriend:update(dt)
			
			return
		end
		
		weeks.updateInput()
		
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
		
		if graphics.fade[1] == 1 and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1
			else
				graphics.fadeOut(1, week1.stop)
				
				return
			end
			
			week1.load()
		end
		
		weeks.updateUI(dt)
		
		weeks.updateEnd(dt)
	end,
	
	draw = function()
		weeks.draw()
		
		if not inGame or gameOver then
			return
		end
		
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
			
			week1.drawUI()
		love.graphics.pop()
	end,
	
	drawUI = function()
		weeks.drawUI()
	end,
	
	stop = function()
		stageBack = nil
		stageFront = nil
		curtains = nil
		
		weeks.stop()
	end
}
