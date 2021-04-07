--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

week3 = {
	init = function()
		weeks.init()
		
		sheets["pico"] = love.graphics.newImage("images/Pico_FNF_assetss.png") -- Not a typo ;)
		
		sky = Image("images/sky.png")
		city = Image("images/city.png")
		behindTrain = Image("images/behindTrain.png")
		street = Image("images/street.png")
		
		street.y = -100
		street.sizeX, street.sizeY = 1.5, 1.5
		
		enemy = love.filesystem.load("sprites/pico-enemy.lua")()
		
		girlfriend.x, girlfriend.y = -70, -40
		enemy.x, enemy.y = -480, 140
		enemy.sizeX = -1 -- Reverse, reverse!
		boyfriend.x, boyfriend.y = 165, 150
		
		enemyIcon:animate("pico", false)
		
		week3.load()
	end,
	
	load = function()
		weeks.load()
		
		if songNum == 3 then
			inst = love.audio.newSource("music/Blammed_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Blammed_Voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/Philly_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Philly_Voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/Pico_Inst.ogg", "stream")
			voices = love.audio.newSource("music/Pico_Voices.ogg", "stream")
		end
		
		week3.initUI()
		
		inst:play()
		weeks.voicesPlay()
	end,
	
	initUI = function()
		weeks.initUI()
		
		if songNum == 3 then
			chart = love.filesystem.load("charts/blammed" .. songAppend .. ".lua")()
		elseif songNum == 2 then
			chart = love.filesystem.load("charts/philly" .. songAppend .. ".lua")()
		else
			chart = love.filesystem.load("charts/pico" .. songAppend .. ".lua")()
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
				
				graphics.fadeOut(3, week3.load)
			elseif input:pressed("gameBack") then
				graphics.fadeOut(1, week3.stop)
			end
			
			boyfriend:update(dt)
			
			return
		end
		
		weeks.updateInput()
		
		weeks.update(dt)
		
		if enemyFrameTimer >= 13 then
			enemy:animate("idle", true)
			enemyFrameTimer = 0
		end
		enemyFrameTimer = enemyFrameTimer + 24 * dt
		
		if health >= 80 then
			if enemyIcon.anim.name == "pico" then
				enemyIcon:animate("pico losing", false)
			end
		else
			if enemyIcon.anim.name == "pico losing" then
				enemyIcon:animate("pico", false)
			end
		end
		
		if graphics.fade[1] == 1 and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1
			else
				graphics.fadeOut(1, week3.stop)
				
				return
			end
			
			week3.load()
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
				love.graphics.translate(cam.x * 0.25, cam.y * 0.25)
				
				sky:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.5, cam.y * 0.5)
				
				city:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.75, cam.y * 0.75)
				
				behindTrain:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
				street:draw()
				
				girlfriend:draw()
				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
		love.graphics.pop()
		
		love.graphics.push()
			love.graphics.scale(uiScale.x, uiScale.y)
			
			week3.drawUI()
		love.graphics.pop()
	end,
	
	drawUI = function()
		weeks.drawUI()
	end,
	
	stop = function()
		sky = nil
		city = nil
		behindTrain = nil
		street = nil
		
		weeks.stop()
	end
}
