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

local upFunc, downFunc, confirmFunc, backFunc, drawFunc, menuFunc, menuDesc, trackNames

local menuState

local menuNum = 1

local weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/weekMenu")))

local enemyDanceLines = love.filesystem.load("sprites/menu/storymenu/idlelines.lua")()

local difficultyAnim = love.filesystem.load("sprites/menu/storymenu/difficulty.lua")()

local bfDanceLines = love.filesystem.load("sprites/menu/storymenu/idlelines.lua")()

local gfDanceLines = love.filesystem.load("sprites/menu/storymenu/idlelines.lua")()

local tutorial, week1, week2, week3, week4, week5, week6

local weekDesc = {
	"LEARN TO FUNK",
	"DADDY DEAREST",
	"SPOOKY MONTH",
	"PICO",
	"MOMMY MUST MURDER",
	"RED SNOW",
	"HATING SIMULATOR FT. MOAWLING"
}
local difficultyStrs = {
	"-easy",
	"",
	"-hard"
}

tutorial = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week0")))
week1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week1")))
week2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week2")))
week3 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week3")))
week4 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week4")))
week5 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week5")))
week6 = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/week6")))

enemyDanceLines.sizeX, enemyDanceLines.sizeY = 0.5, 0.5

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local function switchMenu(menu)

end

enemyDanceLines.x, enemyDanceLines.y = -375, -170

bfDanceLines.sizeX, bfDanceLines.sizeY = 0.7, 0.7
gfDanceLines.sizeX, gfDanceLines.sizeY = 0.5, 0.5

bfDanceLines.x, bfDanceLines.y = 0, -150
gfDanceLines.x, gfDanceLines.y = 375, -170

difficultyAnim.x, difficultyAnim.y = 375 + 25, 220

return {
	enter = function(self, previous)
        bfDanceLines:animate("boyfriend", true)
		gfDanceLines:animate("girlfriend", true)
		enemyDanceLines:animate("week1", true)
		songNum = 0
		weekNum = 1
		trackNames = "\nTutorial"
		menuDesc = "LEARN TO FUNK"

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		function confirmFunc()
			menu:musicStop()
			songNum = 1

			status.setLoading(true)

			graphics.fadeOut(
				0.5,
				function()
					
					songAppend = difficultyStrs[songDifficulty]

					storyMode = true

					Gamestate.switch(weekData[weekNum], songNum, songAppend)

					status.setLoading(false)
				end
			)
		end
		
	end,

	update = function(self, dt)


		function menuFunc()
			if weekNum ~= 7 then
				enemyDanceLines.sizeX, enemyDanceLines.sizeY = 0.5, 0.5
			elseif weekNum == 7 then
				enemyDanceLines.sizeX, enemyDanceLines.sizeY = 1, 1
			end

			if weekNum == 1 then
				trackNames = "\nTutorial"
			elseif weekNum == 2 then
				trackNames = "\nBopeebo\nFresh\nDad-Battle"
			elseif weekNum == 3 then
				trackNames = "\nSpookeez\nSouth\nMonster"
			elseif weekNum == 4 then
				trackNames = "\nPico\nPhilly\nBlammed"
			elseif weekNum == 5 then
				trackNames = "\nSatin-Panties\nHigh\nM.I.L.F"
			elseif weekNum == 6 then
				trackNames = "\nCocoa\nEggnog\nWinter-Horrorland"
			elseif weekNum == 7 then
				trackNames = "\nSenpai\nRoses\nThorns"
			end

			enemyDanceLines:animate("week" .. weekNum, true)
		end
		
		enemyDanceLines:update(dt)
		bfDanceLines:update(dt)
		gfDanceLines:update(dt)

		if songDifficulty == 1 then
			difficultyAnim:animate("easy", true)
		elseif songDifficulty == 2 then
			difficultyAnim:animate("normal", true)
		elseif songDifficulty == 3 then
			difficultyAnim:animate("hard", true)
		end

		difficultyAnim:update(dt)

		if not graphics.isFading() then
			if input:pressed("down") then
				audio.playSound(selectSound)

				if weekNum ~= 7 then
					weekNum = weekNum + 1
				else
					weekNum = 1
				end
				menuFunc()

			elseif input:pressed("up") then
				audio.playSound(selectSound)

				if weekNum ~= 1 then
					weekNum = weekNum - 1
				else
					weekNum = 7
				end
				menuFunc()

			elseif input:pressed("left") then
				audio.playSound(selectSound)

				if songDifficulty ~= 1 then
					songDifficulty = songDifficulty - 1
				else
					songDifficulty = 3 
				end

			elseif input:pressed("right") then
				audio.playSound(selectSound)

				if songDifficulty ~= 3 then
					songDifficulty = songDifficulty + 1
				else
					songDifficulty = 1
				end

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)
                bfDanceLines:animate("boyfriend confirm", false)

				confirmFunc()
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				Gamestate.switch(menuSelect)
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			titleBG:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)

				difficultyAnim:draw()
				if weekNum ~= 1 then
					enemyDanceLines:draw()
				end
				bfDanceLines:draw()
				gfDanceLines:draw()

				if weekNum == 1 then
					tutorial.x, tutorial.y = 0, 220
					week1.y = 320

					tutorial:draw()
					week1:draw()

				elseif weekNum == 2 then
					tutorial.y = 130
					week2.y = 320
					week1.x, week1.y = 0, 220

					tutorial:draw()
					week1:draw()
					week2:draw()

				elseif weekNum == 3 then
					week1.y = 130
					week3.y = 320
					week2.x, week2.y = 0, 220

					week1:draw()
					week2:draw()
					week3:draw()

				elseif weekNum == 4 then
					week2.y = 130
					week4.y = 320
					week3.x, week3.y = 0, 220

					week2:draw()
					week3:draw()
					week4:draw()

				elseif weekNum == 5 then
					week5.y = 320
					week3.y = 130
					week4.x, week4.y = 0, 220

					week3:draw()
					week4:draw()
					week5:draw()

				elseif weekNum == 6 then
					
					week6.y = 320
					week4.y = 130
					week5.x, week5.y = 0, 220
					week4:draw()
					week5:draw()
					week6:draw()
					
				elseif weekNum == 7 then
					week6.x, week6.y = 0, 220
					week5.y = 130

					week5:draw()
					week6:draw()
				end
				
				love.graphics.printf(weekDesc[weekNum], -585, -395, 853, "right", nil, 1.5, 1.5)
				graphics.setColor(255 / 255, 117 / 255, 172 / 255)
				love.graphics.printf("TRACKS" .. trackNames, -1050, 140, 853, "center", nil, 1.5, 1.5)
				graphics.setColor(1,1,1)

			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)

		Timer.clear()
	end
}
