--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

weeks[3] = {
	init = function()
		weeks.init()
		
		cam.sizeX, cam.sizeY = 1, 1
		camScale.x, camScale.y = 1, 1
		
		winColors = {
			{49, 162, 253}, -- Blue
			{49, 253, 140}, -- Green
			{251, 51, 245}, -- Magenta
			{253, 69, 49}, -- Orange
			{251, 166, 51}, -- Yellow
		}
		winColor = 1
		
		sky = Image(love.graphics.newImage("images/sky.png"))
		city = Image(love.graphics.newImage("images/city.png"))
		cityWindows = Image(love.graphics.newImage("images/city-windows.png"))
		behindTrain = Image(love.graphics.newImage("images/behindTrain.png"))
		street = Image(love.graphics.newImage("images/street.png"))
		
		behindTrain.y = -100
		behindTrain.sizeX, behindTrain.sizeY = 1.25, 1.25
		street.y = -100
		street.sizeX, street.sizeY = 1.25, 1.25
		
		enemy = love.filesystem.load("sprites/pico-enemy.lua")()
		
		girlfriend.x, girlfriend.y = -70, -140
		enemy.x, enemy.y = -480, 40
		enemy.sizeX = -1 -- Reverse, reverse!
		boyfriend.x, boyfriend.y = 165, 50
		
		enemyIcon:animate("pico", false)
		
		weeks[3].load()
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
		
		weeks[3].initUI()
		
		inst:play()
		weeks.voicesPlay()
	end,
	
	initUI = function()
		weeks.initUI()
		
		if songNum == 3 then
			weeks.generateNotes(love.filesystem.load("charts/blammed" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks.generateNotes(love.filesystem.load("charts/philly" .. songAppend .. ".lua")())
		else
			weeks.generateNotes(love.filesystem.load("charts/pico" .. songAppend .. ".lua")())
		end
	end,
	
	update = function(dt)
		if gameOver then
			if not graphics.isFading then
				if input:pressed("confirm") then
					inst:stop()
					inst = love.audio.newSource("music/gameOverEnd.ogg", "stream")
					inst:play()
					
					Timer.clear()
					
					cam.x, cam.y = -boyfriend.x, -boyfriend.y
					
					boyfriend:animate("dead confirm", false)
					
					graphics.fadeOut(3, weeks[3].load)
				elseif input:pressed("gameBack") then
					graphics.fadeOut(1, weeks[3].stop)
				end
			end
			
			boyfriend:update(dt)
			
			return
		end
		
		weeks.update(dt)
		
		if musicThres ~= oldMusicThres and math.fmod(musicTime, 240000 / bpm) < 100 then
			winColor = winColor + 1
			
			if winColor > 5 then
				winColor = 1
			end
		end
		
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
		
		if not graphics.isFading and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1
			else
				graphics.fadeOut(1, weeks[3].stop)
				
				return
			end
			
			weeks[3].load()
		end
		
		weeks.updateUI(dt)
	end,
	
	draw = function()
		local curWinColor = winColors[winColor]
		
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
				graphics.setColor(curWinColor[1] / 255, curWinColor[2] / 255, curWinColor[3] / 255)
					cityWindows:draw()
				graphics.setColor(1, 1, 1)
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)
				
				behindTrain:draw()
				street:draw()
				
				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				
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
		sky = nil
		city = nil
		behindTrain = nil
		street = nil
		
		weeks.stop()
	end
}
