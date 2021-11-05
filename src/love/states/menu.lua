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

local upFunc, downFunc, confirmFunc, backFunc, drawFunc

local menuState

local menuNum = 1

local weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local logo = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/logo")))

local girlfriendTitle = love.filesystem.load("sprites/menu/girlfriend-title.lua")()
local titleEnter = love.filesystem.load("sprites/menu/titleEnter.lua")()

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

local music = love.audio.newSource("music/menu/menu.ogg", "stream")

local function switchMenu(menu)
	if menu == 4 then
		love.window.showMessageBox("lol", "Not implemented yet :P")

		return switchMenu(1)
	elseif menu == 3 then
		function upFunc()
			if menuState == 3 then
				songDifficulty = (songDifficulty > 1) and songDifficulty - 1 or 3
			elseif menuState == 2 then
				songNum = (songNum > 1) and songNum - 1 or #weekMeta[weekNum][2]
			else
				weekNum = (weekNum > 1) and weekNum - 1 or #weekMeta
			end
		end
		function downFunc()
			if menuState == 3 then
				songDifficulty = (songDifficulty < 3) and songDifficulty + 1 or 1
			elseif menuState == 2 then
				songNum = (songNum < #weekMeta[weekNum][2]) and songNum + 1 or 1
			else
				weekNum = (weekNum < #weekMeta) and weekNum + 1 or 1
			end
		end
		
		function backFunc()
			if menuState == 1 then
				switchMenu(1)
			else
				menuState = menuState - 1
			end
		end
		
	elseif menu == 2 then
		weekNum = 1
		songNum = 1

		function upFunc()
			if menuState == 2 then
				songDifficulty = (songDifficulty > 1) and songDifficulty - 1 or 3
			else
				weekNum = (weekNum > 1) and weekNum - 1 or #weekMeta
			end
		end
		function downFunc()
			if menuState == 2 then
				songDifficulty = (songDifficulty < 3) and songDifficulty + 1 or 1
			else
				weekNum = (weekNum < #weekMeta) and weekNum + 1 or 1
			end
		end
		
		function backFunc()
			if menuState == 1 then
				switchMenu(1)
			else
				menuState = menuState - 1
			end
		end
	else
		function upFunc()
			menuNum = (menuNum > 1) and menuNum - 1 or #menuNames
		end
		function downFunc()
			menuNum = (menuNum < #menuNames) and menuNum + 1 or 1
		end
		function confirmFunc()
			Gamestate.switch(menuSelect)
		end
		function backFunc()
			graphics.fadeOut(0.5, love.event.quit)
		end
		
	end

	menuState = 1
end

logo.x, logo.y = -350, -125

girlfriendTitle.x, girlfriendTitle.y = 325, 65

titleEnter.x, titleEnter.y = 225, 350

music:setLooping(true)

return {
	enter = function(self, previous)
		songNum = 0

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		music:play()
	end,

	update = function(self, dt)
		girlfriendTitle:update(dt)
		titleEnter:update(dt)
		--titleEnter:animate("anim", true)

		if not graphics.isFading() then
			if input:pressed("up") then
				audio.playSound(selectSound)

				upFunc()
			elseif input:pressed("down") then
				audio.playSound(selectSound)

				downFunc()
			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)

				titleEnter:animate("pressed", false)

				confirmFunc()
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				backFunc()
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)

				logo:draw()

				girlfriendTitle:draw()
				titleEnter:draw()

				--drawFunc()
			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		music:stop()

		Timer.clear()
	end
}
