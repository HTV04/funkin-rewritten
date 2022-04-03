--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2022  HTV04

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

local titleBG = Image(love.graphics.newImage("images/titleBG.png"))

local girlfriendTitle = lovedos.filesystem.load("sprites/gf.lua")()

local weekIDs = {
	"Week 6"
}
local weekSongs = {
	{
		"Senpai",
		"Roses"
		-- "Thorns" -- Broken
	}
}
local difficultyStrs = {
	"-e",
	"",
	"-h"
}

local music = love.audio.newSource("music/freaky.wav")

menu = {
	init = function()
		songNum = 0
		menuState = 0

		inMenu = true

		titleBG = Image(love.graphics.newImage("images/titleBG.png"))

		titleBG.x, titleBG.y = 160, 100

		girlfriendTitle.x, girlfriendTitle.y = 160, 80

		music:setLooping(true)
		music:play()
	end,

	update = function(dt)
		girlfriendTitle:update(dt)

		if input:pressed("left") then
			if menuState == 0 then
				weekNum = weekNum - 1

				if weekNum < 1 then
					weekNum = 1
				end
			elseif menuState == 1 then
				songNum = songNum - 1

				if songNum < 0 then
					songNum = #weekSongs[weekNum]
				end
			elseif menuState == 2 then
				songDifficulty = songDifficulty - 1

				if songDifficulty < 1 then
					songDifficulty = 3
				end
			end
		elseif input:pressed("right") then
			if menuState == 0 then
				weekNum = weekNum + 1

				if weekNum > 1 then
					weekNum = 1
				end
			elseif menuState == 1 then
				songNum = songNum + 1

				if songNum > #weekSongs[weekNum] then
					songNum = 0
				end
			elseif menuState == 2 then
				songDifficulty = songDifficulty + 1

				if songDifficulty > 3 then
					songDifficulty = 1
				end
			end
		elseif input:pressed("confirm") then
			menuState = menuState + 1

			if menuState > 2 then
				music:stop()

				menuState = 2 -- So menuState isn't an "invalid" value

				songAppend = difficultyStrs[songDifficulty]

				inMenu = false
				inGame = true

				if songNum == 0 then
					songNum = 1
					storyMode = true
				end

				weeks[weekNum].init()
			end
		elseif input:pressed("back") then
			menuState = menuState - 1

			if menuState == 0 then
				songNum = 0
			elseif menuState < 0 then
				menuState = 0 -- So menuState isn't an "invalid" value

				love.event.quit()
			end
		end
	end,

	draw = function()
		titleBG:draw()

		girlfriendTitle:draw()

		love.graphics.print("Friday Night Funkin' Rewritten\nBy HTV04\nv2.0.0", 0, 0)

		love.graphics.setColor(255, 255, 0)
		if menuState == 2 then
			if songDifficulty == 1 then
				love.graphics.print("Choose a difficulty: < Easy >", 0, 150)
			elseif songDifficulty == 2 then
				love.graphics.print("Choose a difficulty: < Normal >", 0, 150)
			elseif songDifficulty == 3 then
				love.graphics.print("Choose a difficulty: < Hard >", 0, 150)
			end
		elseif menuState == 1 then
			if songNum == 0 then
				love.graphics.print("Choose a song: < (Story Mode) >", 0, 150)
			else
				love.graphics.print("Choose a song: < " .. weekSongs[weekNum][songNum] .. " >", 0, 150)
			end
		else
			love.graphics.print("Choose a week: < " .. weekIDs[weekNum] .. " >", 0, 150)
		end

		love.graphics.setColor(255, 255, 255)

		if menuState <= 0 then
			love.graphics.print("Arrow Keys: Select | Enter: Confirm | Escape: Exit", 0, 175)
		else
			love.graphics.print("Arrow Keys: Select | Enter: Confirm | Escape: Back", 0, 175)
		end
	end
}
