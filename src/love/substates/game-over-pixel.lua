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

local fromState

local canvas

return {
	enter = function(self, from, canvasObject)
		local boyfriend = fakeBoyfriend or boyfriend

		fromState = from
		canvas = canvasObject

		if inst then inst:stop() end
		voices:stop()

		audio.playSound(sounds["death"])

		boyfriend:animate("dies", false)

		Timer.clear()

		Timer.tween(
			2,
			cam,
			{x = -fakeBoyfriend.x, y = -fakeBoyfriend.y, sizeX = camScale.x, sizeY = camScale.y},
			"out-quad",
			function()
				inst = love.audio.newSource("music/pixel/game-over.ogg", "stream")
				inst:setLooping(true)
				inst:play()

				fakeBoyfriend:animate("dead", true)
			end
		)
	end,

	update = function(self, dt)
		if not graphics.isFading() then
			if input:pressed("confirm") then
				inst:stop()
				inst = love.audio.newSource("music/pixel/game-over-end.ogg", "stream")
				inst:play()

				Timer.clear()

				cam.x, cam.y = -fakeBoyfriend.x, -fakeBoyfriend.y

				fakeBoyfriend:animate("dead confirm", false)

				graphics.fadeOut(
					3,
					function()
						Gamestate.pop()

						fromState:load()
					end
				)
			elseif input:pressed("gameBack") then
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						Gamestate.pop()

						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		fakeBoyfriend:update(dt)
	end,

	draw = function(self)
		local canvasScale

		graphics.screenBase(256, 144)
		love.graphics.setCanvas(canvas)
			love.graphics.clear()

			love.graphics.push()
				love.graphics.translate(math.floor(graphics.getWidth() / 2), math.floor(graphics.getHeight() / 2))

				love.graphics.push()
					love.graphics.scale(cam.sizeX, cam.sizeY)
					love.graphics.translate(math.floor(cam.x), math.floor(cam.y))

					fakeBoyfriend:draw()
				love.graphics.pop()
			love.graphics.pop()
		love.graphics.setCanvas()
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())

		canvasScale = math.min(math.floor(graphics.getWidth() / 256), math.floor(graphics.getHeight() / 144))
		if canvasScale < 1 then canvasScale = math.min(graphics.getWidth() / 256, graphics.getHeight() / 144) end

		love.graphics.draw(canvas, graphics.getWidth() / 2, graphics.getHeight() / 2, nil, canvasScale, canvasScale, 128, 72)
	end
}
