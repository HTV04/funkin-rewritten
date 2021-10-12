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

local menuID, selection
local curDir, dirTable
local sprite, spriteAnims, overlaySprite

return {
	spriteViewerSearch = function(self, dir)
		svMode = 1

		if curDir then
			curDir = curDir .. "/" .. dir
		else
			curDir = dir
		end
		selection = 1
		dirTable = love.filesystem.getDirectoryItems(curDir)
	end,

	enter = function(self, previous)
		menuID = 1
		selection = 3

		menus = {
			{
				1,
				"Really Bad Debug Menu",
				{
					"Sprite Viewer",
					function()
						menuID = 2

						self:spriteViewerSearch("sprites")
					end
				}
			},
			{2}
		}

		graphics.setFade(0)
		graphics.fadeIn(0.5)
	end,

	keypressed = function(self, key)
		if menus[menuID][1] == 2 then -- Sprite viewer
			if svMode == 2 then
				if key == "w" then
					overlaySprite.y = overlaySprite.y - 1
				elseif key == "a" then
					overlaySprite.x = overlaySprite.x - 1
				elseif key == "s" then
					overlaySprite.y = overlaySprite.y + 1
				elseif key == "d" then
					overlaySprite.x = overlaySprite.x + 1
				end
			end
		end
	end,

	spriteViewer = function(self, spritePath)
		local spriteData = love.filesystem.load(spritePath)

		svMode = 2

		sprite = spriteData()
		overlaySprite = spriteData()

		spriteAnims = {}
		for i, _ in pairs(sprite.getAnims()) do
			table.insert(spriteAnims, i)
		end

		sprite:animate(spriteAnims[1], false)
		overlaySprite:animate(spriteAnims[1], false)
	end,

	update = function(self, dt)
		-- I wasn't kidding when I said this was a really bad debug menu
		if menus[menuID][1] == 2 then -- Sprite viewer
			if svMode == 2 then
				sprite:update(dt)
				overlaySprite:update(dt)

				if input:pressed("up") then
					selection = selection - 1

					if selection < 1 then
						selection = #spriteAnims
					end

					sprite:animate(spriteAnims[selection], false)
				end
				if input:pressed("down") then
					selection = selection + 1

					if selection > #spriteAnims then
						selection = 1
					end

					sprite:animate(spriteAnims[selection], false)
				end
				if input:pressed("confirm") then
					overlaySprite:animate(spriteAnims[selection], false)
				end
			else
				if input:pressed("up") then
					selection = selection - 1

					if selection < 1 then
						selection = #dirTable
					end
				end
				if input:pressed("down") then
					selection = selection + 1

					if selection > #dirTable then
						selection = 1
					end
				end
				if input:pressed("confirm") then
					if love.filesystem.getInfo(curDir .. "/" .. dirTable[selection]).type == "directory" then
						self:spriteViewerSearch(dirTable[selection])
					else
						self:spriteViewer(curDir .. "/" .. dirTable[selection])
					end
				end
			end
		else -- Standard menu
			if input:pressed("up") then
				selection = selection - 1

				if selection < 3 then
					selection = #menus[menuID]
				end
			end
			if input:pressed("down") then
				selection = selection + 1

				if selection > #menus[menuID] then
					selection = 3
				end
			end
			if input:pressed("confirm") then
				menus[menuID][selection][2]()
			end
		end

		if input:pressed("back") then
			graphics.fadeOut(0.5, love.event.quit)
		end
	end,

	draw = function(self)
		if menus[menuID][1] == 2 then -- Sprite viewer
			if svMode == 2 then
				graphics.clear(0.5, 0.5, 0.5)

				love.graphics.push()
					love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)

					sprite:draw()
					graphics.setColor(1, 1, 1, 0.5)
					overlaySprite:draw()
					graphics.setColor(1, 1, 1)

				love.graphics.pop()

				for i = 1, #spriteAnims do
					if i == selection then
						graphics.setColor(1, 1, 0)
					end
					love.graphics.print(spriteAnims[i], 0, (i - 1) * 20)
					graphics.setColor(1, 1, 1)

					love.graphics.print("X: " .. tostring(sprite.x - overlaySprite.x), 0, (#spriteAnims + 1) * 20)
					love.graphics.print("Y: " .. tostring(sprite.y - overlaySprite.y), 0, (#spriteAnims + 2) * 20)
				end
			else
				for i = 1, #dirTable do
					if i == selection then
						graphics.setColor(1, 1, 0)
					elseif love.filesystem.getInfo(curDir .. "/" .. dirTable[i]).type == "directory" then
						graphics.setColor(1, 0, 1)
					end
					love.graphics.print(dirTable[i], 0, (i - 1) * 20)
					graphics.setColor(1, 1, 1)
				end
			end
		else -- Standard menu
			love.graphics.print(menus[menuID][2])

			for i = 3, #menus[menuID] do
				if i == selection then
					graphics.setColor(1, 1, 0)
				end
				love.graphics.print(menus[menuID][i][1], 0, (i - 1) * 20)
				graphics.setColor(1, 1, 1)

				love.graphics.print("Press Esc to exit at any time", 0, (#menus[menuID] + 1) * 20)
			end
		end
	end
}
