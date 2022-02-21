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

local leftFunc, rightFunc, confirmFunc, backFunc, drawFunc

local menuState

local menuNum = 1

local weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local titleBG = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/title-bg")))


local menuNames = {
	"Story Mode",
	"Freeplay",
	"Options"
}

local weekMeta = {
	{
		"Tutorial",
		{
			"Tutorial"
		}
	},
	{
		"Week 1",
		{
			"Bopeebo",
			"Fresh",
			"Dadbattle"
		}
	},
	{
		"Week 2",
		{
			"Spookeez",
			"South",
			"Monster"
		}
	},
	{
		"Week 3",
		{
			"Pico",
			"Philly Nice",
			"Blammed"
		}
	},
	{
		"Week 4",
		{
			"Satin Panties",
			"High",
			"M.I.L.F"
		}
	},
	{
		"Week 5",
		{
			"Cocoa",
			"Eggnog",
			"Winter Horrorland"
		}
	},
	{
		"Week 6",
		{
			"Senpai",
			"Roses",
			"Thorns"
		}
	}
}
local difficultyStrs = {
	"-easy",
	"",
	"-hard"
}

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")


local function switchMenu(menu)
	if menu == 4 then
		love.window.showMessageBox("lol", "Not implemented yet :P")

		return switchMenu(1)
	elseif menu == 3 then
		
	elseif menu == 2 then
		function leftFunc()
			if menuState == 3 then
				songDifficulty = (songDifficulty > 1) and songDifficulty - 1 or 3
			elseif menuState == 2 then
				songNum = (songNum > 1) and songNum - 1 or #weekMeta[weekNum][2]
			else
				weekNum = (weekNum > 1) and weekNum - 1 or #weekMeta
			end
		end
		function rightFunc()
			if menuState == 3 then
				songDifficulty = (songDifficulty < 3) and songDifficulty + 1 or 1
			elseif menuState == 2 then
				songNum = (songNum < #weekMeta[weekNum][2]) and songNum + 1 or 1
			else
				weekNum = (weekNum < #weekMeta) and weekNum + 1 or 1
			end
		end
		function confirmFunc()
			if menuState == 3 then

				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						songAppend = difficultyStrs[songDifficulty]

						storyMode = false

						Gamestate.switch(weekData[weekNum], songNum, songAppend)

						status.setLoading(false)
					end
				)
			else
				if menuState == 1 then
					songNum = 1
				end

				menuState = menuState + 1
			end
		end
		function backFunc()
			if menuState == 1 then
				switchMenu(1)
			else
				menuState = menuState - 1
			end
		end
		function drawFunc()
			graphics.setColor(1, 1, 0)
			if menuState == 3 then
				if songDifficulty == 3 then
					love.graphics.printf("Choose a difficulty: < Hard >", -640, 285, 853, "center", nil, 1.5, 1.5)
				elseif songDifficulty == 2 then
					love.graphics.printf("Choose a difficulty: < Normal >", -640, 285, 853, "center", nil, 1.5, 1.5)
				else
					love.graphics.printf("Choose a difficulty: < Easy >", -640, 285, 853, "center", nil, 1.5, 1.5)
				end
			elseif menuState == 2 then
				love.graphics.printf("Choose a song: < " .. weekMeta[weekNum][2][songNum] .. " >", -640, 285, 853, "center", nil, 1.5, 1.5)
			else
				love.graphics.printf("Choose a week: < " .. weekMeta[weekNum][1] .. " >", -640, 285, 853, "center", nil, 1.5, 1.5)
			end
			graphics.setColor(1, 1, 1)

		end
	end

	menuState = 1
end

function leftFunc()
	if menuState == 3 then
		songDifficulty = (songDifficulty > 1) and songDifficulty - 1 or 3
	elseif menuState == 2 then
		songNum = (songNum > 1) and songNum - 1 or #weekMeta[weekNum][2]
	else
		weekNum = (weekNum > 1) and weekNum - 1 or #weekMeta
	end
end
function rightFunc()
	if menuState == 3 then
		songDifficulty = (songDifficulty < 3) and songDifficulty + 1 or 1
	elseif menuState == 2 then
		songNum = (songNum < #weekMeta[weekNum][2]) and songNum + 1 or 1
	else
		weekNum = (weekNum < #weekMeta) and weekNum + 1 or 1
	end
end
function confirmFunc()
	if menuState == 3 then

		status.setLoading(true)

		graphics.fadeOut(
			0.5,
			function()
				menu:musicStop()
				
				songAppend = difficultyStrs[songDifficulty]

				storyMode = false

				Gamestate.switch(weekData[weekNum], songNum, songAppend)

				status.setLoading(false)
			end
		)
	else
		if menuState == 1 then
			songNum = 1
		end

		menuState = menuState + 1
	end
end
function backFunc()
	if menuState == 1 then
		switchMenu(1)
	else
		menuState = menuState - 1
	end
end

function drawFunc()
	graphics.setColor(1, 1, 0)
	if menuState == 3 then
		if songDifficulty == 3 then
			love.graphics.printf("Choose a difficulty: < Hard >", -640, 285, 853, "center", nil, 1.5, 1.5)
		elseif songDifficulty == 2 then
			love.graphics.printf("Choose a difficulty: < Normal >", -640, 285, 853, "center", nil, 1.5, 1.5)
		else
			love.graphics.printf("Choose a difficulty: < Easy >", -640, 285, 853, "center", nil, 1.5, 1.5)
		end
	elseif menuState == 2 then
		love.graphics.printf("Choose a song: < " .. weekMeta[weekNum][2][songNum] .. " >", -640, 285, 853, "center", nil, 1.5, 1.5)
	else
		love.graphics.printf("Choose a week: < " .. weekMeta[weekNum][1] .. " >", -640, 285, 853, "center", nil, 1.5, 1.5)
	end
	graphics.setColor(1, 1, 1)
end

return {
	enter = function(self, previous)
		songNum = 0

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

	end,

	update = function(self, dt)

		if not graphics.isFading() then
			if input:pressed("left") then
				audio.playSound(selectSound)

				leftFunc()
			elseif input:pressed("right") then
				audio.playSound(selectSound)

				rightFunc()
			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)

				confirmFunc()
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				if menuState == 1 then
					Gamestate.switch(menuSelect)
				else
					menuState = menuState - 1
				end
				
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			titleBG:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)

				drawFunc()
			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)

		Timer.clear()
	end
}
