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

weeks[1] = {
	init = function()
		weeks.init()

		cam.x, cam.y = 25, 0

		sky = Image(love.graphics.newImage("images/weeb1.png"))
		school = Image(love.graphics.newImage("images/weeb2.png"))
		street = Image(love.graphics.newImage("images/weeb3.png"))

		enemyIcon:animate("senpai", false)

		weeks[1].load()
	end,

	load = function()
		if songNum == 3 then
			inst = love.audio.newSource("music/thorns-i.wav")
			voices = love.audio.newSource("music/thorns-v.wav")
		elseif songNum == 2 then
			enemy = lovedos.filesystem.load("sprites/senpai2.lua")()

			inst = love.audio.newSource("music/roses-i.wav")
			voices = love.audio.newSource("music/roses-v.wav")
		else
			enemy = lovedos.filesystem.load("sprites/senpai.lua")()

			inst = love.audio.newSource("music/senpai-i.wav")
			voices = love.audio.newSource("music/senpai-v.wav")
		end

		weeks.load()

		weeks[1].initUI()

		inst:play()
		weeks.voicesPlay()
	end,

	initUI = function()
		weeks.initUI()

		if songNum == 3 then
			weeks.generateNotes(lovedos.filesystem.load("charts/thorns" .. songAppend .. ".lua")())
		elseif songNum == 2 then
			weeks.generateNotes(lovedos.filesystem.load("charts/roses" .. songAppend .. ".lua")())
		else
			weeks.generateNotes(lovedos.filesystem.load("charts/senpai" .. songAppend .. ".lua")())
		end
	end,

	update = function(dt)
		local doneCnt = 0

		if gameOver then
			if input:pressed("confirm") then
				Timer.clear()

				cam.x, cam.y = 25, 0

				weeks[1].load()
			elseif input:pressed("gameBack") then
				weeks[1].stop()
			end

			fakeBoyfriend:update(dt)
			weeks.syncCamera(fakeBoyfriend, 50, 30)

			return
		end

		weeks.update(dt)

		for i = 1, #events do
			if events[i].eventTime <= musicTime then
				if events[i].bpm then
					bpm = events[i].bpm

					girlfriend.anim.speed = 14.4 / (60 / bpm)
				end

				if camTimer then
					Timer.cancel(camTimer)
				end
				if events[i].mustHitSection then
					camTimer = Timer.tween(1.25, cam, {x = -25}, "out-quad")
				else
					camTimer = Timer.tween(1.25, cam, {x = 25}, "out-quad")
				end

				table.remove(events, i)

				break
			end
		end

		weeks.syncCamera(sky)
		weeks.syncCamera(school)
		weeks.syncCamera(street)

		weeks.syncCamera(girlfriend, 0, 0)
		weeks.syncCamera(enemy, -50, 0)
		weeks.syncCamera(boyfriend, 50, 30)

		if enemyFrameTimer >= 12 then
			enemy:animate("idle", true)
			enemyFrameTimer = 0
		end
		enemyFrameTimer = enemyFrameTimer + 24 * dt

		if not voices:isPlaying() then
			if storyMode and songNum < 2 then -- Thorns is broken
				songNum = songNum + 1
			else
				graphics.fadeOut(1, weeks[1].stop)

				return
			end

			weeks[1].load()
		end

		weeks.updateUI(dt)
	end,

	draw = function()
		weeks.draw()

		if not inGame or gameOver then return end

		sky:draw()
		school:draw()
		street:draw()

		girlfriend:draw()
		enemy:draw()
		boyfriend:draw()

		weeks.drawUI()
	end,

	stop = function()
		sky = nil
		school = nil
		street = nil

		weeks.stop()
	end
}
