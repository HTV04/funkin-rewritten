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

local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

return {
	enter = function(self, previous)
		graphics.setFade(0)
		graphics.fadeIn(0.5)
	end,

	mousepressed = function(self, x, y, button, istouch, presses)
		if button == 1 and not graphics.isFading() then
			confirmSound:play()

			graphics.fadeOut(
				0.5,
				function()
					Gamestate.switch(menu)
				end
			)
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)

				love.graphics.printf("Click to start game", -1280, 0, 1280, "center", nil, 2, 2)
			love.graphics.pop()
		love.graphics.pop()
	end
}
