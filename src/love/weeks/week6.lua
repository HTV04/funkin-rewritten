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

local canvas

local sky, school, street

return {
	enter = function(self)
		love.graphics.setDefaultFilter("nearest")

		status.setNoResize(true)

		canvas = love.graphics.newCanvas(256, 144)
		canvas:setFilter("nearest")

		weeksPixel:enter()

		cam.sizeX, cam.sizeY = 1, 1
		camScale.x, camScale.y = 1, 1

		sky = graphics.newPixelImage(love.graphics.newImage(graphics.imagePath("week6/sky")))
		school = graphics.newPixelImage(love.graphics.newImage(graphics.imagePath("week6/school")))
		street = graphics.newPixelImage(love.graphics.newImage(graphics.imagePath("week6/street")))

		boyfriend.x, boyfriend.y = 50, 30
		--fakeBoyfriend.x, fakeBoyfriend.y = 50, 30

		enemyIcon:animate("senpai", false)

		self:load()
	end,

	load = function(self)
		if songNum == 2 then
			enemy = love.filesystem.load("sprites/week6/senpai-angry.lua")()
		else
			enemy = love.filesystem.load("sprites/week6/senpai.lua")()
		end

		weeksPixel:load()

		if songNum == 3 then
			inst = love.audio.newSource("music/week6/thorns-inst.ogg", "stream")
			voices = love.audio.newSource("music/week6/thorns-voices.ogg", "stream")
		elseif songNum == 2 then
			inst = love.audio.newSource("music/week6/roses-inst.ogg", "stream")
			voices = love.audio.newSource("music/week6/roses-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/week6/senpai-inst.ogg", "stream")
			voices = love.audio.newSource("music/week6/senpai-voices.ogg", "stream")
		end
		enemy.x, enemy.y = -50, 0

		self:initUI()

		inst:play()
		weeksPixel:voicesPlay()
	end,

	initUI = function(self)
		weeksPixel:initUI()

		if songNum == 3 then
			weeksPixel:generateNotes(love.filesystem.load("charts/week6/thorns" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeksPixel:generateNotes(love.filesystem.load("charts/week6/roses" .. songAppend .. ".lua")())
		else
			weeksPixel:generateNotes(love.filesystem.load("charts/week6/senpai" .. songAppend .. ".lua")())
		end
	end,

	update = function(self, dt)
		graphics.screenBase(128, 72)

		if gameOver then
			if not graphics.isFading() then
				if input:pressed("confirm") then
					inst:stop()
					inst = love.audio.newSource("music/game-over-end.ogg", "stream")
					inst:play()

					Timer.clear()

					cam.x, cam.y = -boyfriend.x, -boyfriend.y

					fakeBoyfriend:animate("dead confirm", false)

					graphics.fadeOut(3, function() self:load() end)
				elseif input:pressed("gameBack") then
					graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
				end
			end

			boyfriend:update(dt)

			return
		end

		weeksPixel:update(dt)

		if not graphics.isFading() and not inst:isPlaying() and not voices:isPlaying() then
			if storyMode and songNum < 3 then
				songNum = songNum + 1

				self:load()
			else
				graphics.fadeOut(0.5, function() Gamestate.switch(menu) end)
			end
		end

		weeksPixel:updateUI(dt)
	end,

	draw = function(self)
		local canvasScale

		graphics.screenBase(128, 72)
		love.graphics.setCanvas(canvas)
			love.graphics.clear()

			weeksPixel:draw()

			if gameOver then
				love.graphics.setCanvas()

				return
			end

			love.graphics.push()
				love.graphics.translate(128, 72)
				love.graphics.scale(cam.sizeX, cam.sizeY)

				love.graphics.push()
					love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

					sky:draw()
					school:draw()
				love.graphics.pop()
				love.graphics.push()
					love.graphics.translate(cam.x, cam.y)

					street:draw()

					girlfriend:draw()
					enemy:draw()
					boyfriend:draw()
				love.graphics.pop()
				--weeksPixel:drawRating(0.9)
			love.graphics.pop()

			weeksPixel:drawUI()
		love.graphics.setCanvas()
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())

		canvasScale = math.min(math.floor(graphics.getWidth() / 256), math.floor(graphics.getHeight() / 128))
		if canvasScale < 1 then canvasScale = math.min(graphics.getWidth() / 256, graphics.getHeight() / 128) end

		love.graphics.draw(canvas, graphics.getWidth() / 2, graphics.getHeight() / 2, nil, canvasScale, canvasScale, 128, 72)
	end,

	leave = function(self)
		canvas = nil

		sky = nil
		school = nil
		street = nil

		weeksPixel:leave()

		status.setNoResize(false)

		love.graphics.setDefaultFilter("linear")
	end
}
