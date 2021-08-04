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

local titleBG = Image(love.graphics.newImage(graphics.imagePath("menu/title-bg")))
local logo = Image(love.graphics.newImage(graphics.imagePath("menu/logo")))

local girlfriendTitle = love.filesystem.load("sprites/menu/girlfriend-title.lua")()

local weekIDs = {
	"Tutorial",
	"Week 1",
	"Week 2",
	"Week 3",
	"Week 4",
	"Week 5"
}
local weekSongs = {
	{
		"Tutorial"
	},
	{
		"Bopeebo",
		"Fresh",
		"Dadbattle"
	},
	{
		"Spookeez",
		"South"
	},
	{
		"Pico",
		"Philly Nice",
		"Blammed"
	},
	{
		"Satin Panties",
		"High",
		"M.I.L.F"
	},
	{
		"Cocoa",
		"Eggnog",
		"Winter Horrorland"
	}
}
local difficultyStrs = {
	"-easy",
	"",
	"-hard"
}

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local music = love.audio.newSource("music/menu/menu.ogg", "stream")

logo.x, logo.y = -350, -125

girlfriendTitle.x, girlfriendTitle.y = 300, -75

music:setLooping(true)

return {
	enter = function(self)
		gameOver = false
		storyMode = false
		
		songNum = 0
		menuState = 0
		
		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9
		
		graphics.cancelTimer()
		graphics.fade[1] = 0
		graphics.fadeIn(0.5)
		
		music:play()
	end,
	
	update = function(self, dt)
		girlfriendTitle:update(dt)
		
		if not graphics.isFading then
			if input:pressed("left") then
				audio.playSound(selectSound)
				
				if menuState == 2 then
					songDifficulty = songDifficulty - 1
					
					if songDifficulty < 1 then
						songDifficulty = 3
					end
				elseif menuState == 1 then
					songNum = songNum - 1
					
					if songNum < 0 then
						songNum = #weekSongs[weekNum]
					end
				elseif menuState == 0 then
					weekNum = weekNum - 1
					
					if weekNum < 1 then
						weekNum = #weekIDs
					end
				end
			elseif input:pressed("right") then
				audio.playSound(selectSound)
				
				if menuState == 2 then
					songDifficulty = songDifficulty + 1
					
					if songDifficulty > 3 then
						songDifficulty = 1
					end
				elseif menuState == 1 then
					songNum = songNum + 1
					
					if songNum > #weekSongs[weekNum] then
						songNum = 0
					end
				elseif menuState == 0 then
					weekNum = weekNum + 1
					
					if weekNum > #weekIDs then
						weekNum = 1
					end
				end
			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)
				
				menuState = menuState + 1
				
				if menuState > 2 then
					music:stop()
					
					isLoading = true
					
					menuState = 2 -- So menuState isn't an "invalid" value
					
					graphics.fadeOut(
						0.5,
						function()
							songAppend = difficultyStrs[songDifficulty]
							
							if songNum == 0 then
								songNum = 1
								storyMode = true
							end
							
							Gamestate.switch(weekData[weekNum])
							
							isLoading = false
						end
					)
				end
			elseif input:pressed("back") then
				if menuState > 0 then -- Don't play sound if exiting the game
					audio.playSound(selectSound)
				end
				
				menuState = menuState - 1
				
				if menuState == 0 then
					songNum = 0
				elseif menuState < 0 then
					menuState = 0 -- So menuState isn't an "invalid" value
					
					graphics.fadeOut(0.5, love.event.quit)
				end
			end
		end
	end,
	
	draw = function(self)
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			
			titleBG:draw()
			
			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
				
				logo:draw()
				
				girlfriendTitle:draw()
				
				love.graphics.printf(
					"v1.0.1\n" ..
					"Developed by HTV04\n\n" ..
					"Original game by Funkin' Crew, in association with Newgrounds",
					-525,
					90,
					450,
					"right",
					nil,
					1,
					1
				)
				
				graphics.setColor(1, 1, 0)
				if menuState == 2 then
					if songDifficulty == 1 then
						love.graphics.printf("Choose a difficulty: < Easy >", -640, 285, 853, "center", nil, 1.5, 1.5)
					elseif songDifficulty == 2 then
						love.graphics.printf("Choose a difficulty: < Normal >", -640, 285, 853, "center", nil, 1.5, 1.5)
					elseif songDifficulty == 3 then
						love.graphics.printf("Choose a difficulty: < Hard >", -640, 285, 853, "center", nil, 1.5, 1.5)
					end
				elseif menuState == 1 then
					if songNum == 0 then
						love.graphics.printf("Choose a song: < (Story Mode) >", -640, 285, 853, "center", nil, 1.5, 1.5)
					else
						love.graphics.printf("Choose a song: < " .. weekSongs[weekNum][songNum] .. " >", -640, 285, 853, "center", nil, 1.5, 1.5)
					end
				elseif menuState == 0 then
					love.graphics.printf("Choose a week: < " .. weekIDs[weekNum] .. " >", -640, 285, 853, "center", nil, 1.5, 1.5)
				end
				graphics.setColor(1, 1, 1)
				
				if menuState <= 0 then
					if input:getActiveDevice() == "joy" then
						love.graphics.printf("Left Stick/D-Pad: Select | A: Confirm | B: Exit", -640, 350, 1280, "center", nil, 1, 1)
					else
						love.graphics.printf("Arrow Keys: Select | Enter: Confirm | Escape: Exit", -640, 350, 1280, "center", nil, 1, 1)
					end
				else
					if input:getActiveDevice() == "joy" then
						love.graphics.printf("Left Stick/D-Pad: Select | A: Confirm | B: Back", -640, 350, 1280, "center", nil, 1, 1)
					else
						love.graphics.printf("Arrow Keys: Select | Enter: Confirm | Escape: Back", -640, 350, 1280, "center", nil, 1, 1)
					end
				end
			love.graphics.pop()
		love.graphics.pop()
	end,
	
	leave = function(self)
		music:stop()
		
		Timer.clear()
	end
}
