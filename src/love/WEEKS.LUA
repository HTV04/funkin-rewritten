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

local animList = {
	"left",
	"down",
	"up",
	"right"
}
local inputList = {
	"gameLeft",
	"gameDown",
	"gameUp",
	"gameRight"
}

weeks = {
	init = function()
		bpm = 100

		enemyFrameTimer = 0
		boyfriendFrameTimer = 0

		sheets = {
			["icons"] = love.graphics.newImage("images/icons.png"),
			["arrows"] = love.graphics.newImage("images/arrows.png")
		}

		sprites = {
			["icons"] = lovedos.filesystem.load("sprites/icons.lua")
		}

		girlfriend = lovedos.filesystem.load("sprites/gf.lua")()
		boyfriend = lovedos.filesystem.load("sprites/bf.lua")()
		fakeBoyfriend = lovedos.filesystem.load("sprites/bfdead.lua")()

		enemyIcon = sprites["icons"]()
		boyfriendIcon = sprites["icons"]()

		enemyIcon.y = 172
		boyfriendIcon.y = 172
		boyfriendIcon.flip = true
	end,

	load = function()
		gameOver = false

		girlfriendFrameTimer = 0

		enemy:animate("idle")
		boyfriend:animate("idle")
	end,

	initUI = function()
		events = {}
		enemyNotes = {}
		boyfriendNotes = {}
		health = 50
		score = 0

		sprites["left arrow"] = lovedos.filesystem.load("sprites/left.lua")
		sprites["down arrow"] = lovedos.filesystem.load("sprites/down.lua")
		sprites["up arrow"] = lovedos.filesystem.load("sprites/up.lua")
		sprites["right arrow"] = lovedos.filesystem.load("sprites/right.lua")

		enemyArrows = {
			sprites["left arrow"](),
			sprites["down arrow"](),
			sprites["up arrow"](),
			sprites["right arrow"]()
		}
		boyfriendArrows= {
			sprites["left arrow"](),
			sprites["down arrow"](),
			sprites["up arrow"](),
			sprites["right arrow"]()
		}

		for i = 1, 4 do
			enemyArrows[i].x = 20 * i
			enemyArrows[i].y = 20
			boyfriendArrows[i].x = 220 + 20 * i
			boyfriendArrows[i].y = 20

			enemyNotes[i] = {}
			boyfriendNotes[i] = {}
		end
	end,

	generateNotes = function(chart)
		speed = chart.speed

		local bpm = 100

		for i = 1, #chart do
			local oldBpm = bpm

			bpm = chart[i].bpm

			if not bpm then
				bpm = oldBpm
			end

			for j = 1, #chart[i].sectionNotes do
				local sprite

				local mustHitSection = chart[i].mustHitSection
				local noteType = chart[i].sectionNotes[j].noteType
				local noteTime = chart[i].sectionNotes[j].noteTime

				if j == 1 then
					table.insert(events, {eventTime = chart[i].sectionNotes[1].noteTime, mustHitSection = mustHitSection, bpm = bpm})
				end

				if noteType == 0 or noteType == 4 then
					sprite = sprites["left arrow"]
				elseif noteType == 1 or noteType == 5 then
					sprite = sprites["down arrow"]
				elseif noteType == 2 or noteType == 6 then
					sprite = sprites["up arrow"]
				elseif noteType == 3 or noteType == 7 then
					sprite = sprites["right arrow"]
				end

				if mustHitSection then
					if noteType >= 4 then
						local id = noteType - 3
						local c = #enemyNotes[id] + 1
						local x = enemyArrows[id].x

						table.insert(enemyNotes[id], sprite())
						enemyNotes[id][c].x = x
						enemyNotes[id][c].y = 20 + noteTime * 0.12 * speed
						enemyNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 141 / speed, chart[i].sectionNotes[j].noteLength, 141 / speed do
								local c = #enemyNotes[id] + 1

								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = 20 + (noteTime + k) * 0.12 * speed
								if k > chart[i].sectionNotes[j].noteLength - 141 / speed then
									enemyNotes[id][c]:animate("end", false)
								else
									enemyNotes[id][c]:animate("hold", false)
								end
							end
						end
					else
						local id = noteType + 1
						local c = #boyfriendNotes[id] + 1
						local x = boyfriendArrows[id].x

						table.insert(boyfriendNotes[id], sprite())
						boyfriendNotes[id][c].x = x
						boyfriendNotes[id][c].y = 20 + noteTime * 0.12 * speed
						boyfriendNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 141 / speed, chart[i].sectionNotes[j].noteLength, 141 / speed do
								local c = #boyfriendNotes[id] + 1

								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = 20 + (noteTime + k) * 0.12 * speed
								if k > chart[i].sectionNotes[j].noteLength - 141 / speed then
									boyfriendNotes[id][c]:animate("end", false)
								else
									boyfriendNotes[id][c]:animate("hold", false)
								end
							end
						end
					end
				else
					if noteType >= 4 then
						local id = noteType - 3
						local c = #boyfriendNotes[id] + 1
						local x = boyfriendArrows[id].x

						table.insert(boyfriendNotes[id], sprite())
						boyfriendNotes[id][c].x = x
						boyfriendNotes[id][c].y = 20 + noteTime * 0.12 * speed
						boyfriendNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 141 / speed, chart[i].sectionNotes[j].noteLength, 141 / speed do
								local c = #boyfriendNotes[id] + 1

								table.insert(boyfriendNotes[id], sprite())
								boyfriendNotes[id][c].x = x
								boyfriendNotes[id][c].y = 20 + (noteTime + k) * 0.12 * speed
								if k > chart[i].sectionNotes[j].noteLength - 141 / speed then
									boyfriendNotes[id][c]:animate("end", false)
								else
									boyfriendNotes[id][c]:animate("hold", false)
								end
							end
						end
					else
						local id = noteType + 1
						local c = #enemyNotes[id] + 1
						local x = enemyArrows[id].x

						table.insert(enemyNotes[id], sprite())
						enemyNotes[id][c].x = x
						enemyNotes[id][c].y = 20 + noteTime * 0.12 * speed
						enemyNotes[id][c]:animate("on", false)
						if chart[i].sectionNotes[j].noteLength > 0 then
							for k = 141 / speed, chart[i].sectionNotes[j].noteLength, 141 / speed do
								local c = #enemyNotes[id] + 1

								table.insert(enemyNotes[id], sprite())
								enemyNotes[id][c].x = x
								enemyNotes[id][c].y = 20 + (noteTime + k) * 0.12 * speed
								if k > chart[i].sectionNotes[j].noteLength - 141 / speed then
									enemyNotes[id][c]:animate("end", false)
								else
									enemyNotes[id][c]:animate("hold", false)
								end
							end
						end
					end
				end
			end

			for i = 1, 4 do
				table.sort(enemyNotes[i], function(a, b) return a.y < b.y end)
				table.sort(boyfriendNotes[i], function(a, b) return a.y < b.y end)
			end
		end
	end,

	voicesPlay = function()
		musicThres = 0
		previousFrameTime = love.timer.getTime() * 1000
		lastReportedPlaytime = 0
		musicTime = 0

		voices:play()
	end,

	update = function(dt)
		oldMusicThres = musicThres

		musicTime = musicTime + 1000 * dt

		musicThres = math.floor(musicTime / 100) -- Since "musicTime" isn't precise, this is needed

		girlfriend:update(dt)
		enemy:update(dt)
		boyfriend:update(dt)

		if girlfriendFrameTimer >= 29 then
			girlfriend:animate("idle", true)
			girlfriend.anim.speed = 14.4 / (60 / bpm)

			girlfriendFrameTimer = 0
		end
		girlfriendFrameTimer = girlfriendFrameTimer + 14.4 / (60 / bpm) * dt

		if boyfriendFrameTimer >= 13 then
			boyfriend:animate("idle", true)
			boyfriendFrameTimer = 0
		end
		boyfriendFrameTimer = boyfriendFrameTimer + 24 * dt
	end,

	syncCamera = function(object, x, y, offset)

		if not x then x = 0 end
		if not y then y = 0 end
		if not offset then offset = 1 end

		object.x = 160 + cam.x * offset + x
		object.y = 100 + cam.y * offset + y
	end,

	updateUI = function(dt)
		for i = 1, 4 do
			local enemyArrow = enemyArrows[i]
			local boyfriendArrow = boyfriendArrows[i]
			local enemyNote = enemyNotes[i]
			local boyfriendNote = boyfriendNotes[i]
			local curAnim = animList[i]
			local curInput = inputList[i]

			enemyArrow:update(dt)
			boyfriendArrow:update(dt)

			if not enemyArrow.animated then
				enemyArrow:animate("off", false)
			end

			if #enemyNote > 0 then
				for j = 1, #enemyNote do
					enemyNote[j].offsetY = musicTime * 0.12 * speed
				end

				if enemyNote[1].y - enemyNote[1].offsetY < 20 then
					if enemyNote[1].x == enemyArrow.x then
						enemyArrow:animate("confirm", false)

						enemy:animate(curAnim, false)
						enemyFrameTimer = 0

						table.remove(enemyNote, 1)
					end
				end
			end

			if #boyfriendNote > 0 then
				for j = 1, #boyfriendNote do
					boyfriendNote[j].offsetY = musicTime * 0.12 * speed
				end

				if boyfriendNote[1].y - boyfriendNote[1].offsetY < 6 then
					table.remove(boyfriendNote, 1)

					health = health - 2
				end
			end

			if input:pressed(curInput) then
				local success = false

				if settings.kadeInput then
					success = true
				end

				boyfriendArrow:animate("press", false)

				if #boyfriendNote > 0 then
					if boyfriendNote[1].anim.name == "on" and boyfriendNote[1].x == boyfriendArrow.x and boyfriendNote[1].y - boyfriendNote[1].offsetY <= 36 then
						local notePos = math.abs(20 - (boyfriendNote[1].y - boyfriendNote[1].offsetY))

						if notePos <= 4 then -- "Sick"
							score = score + 350
						elseif notePos <= 9 then -- "Good"
							score = score + 200
						elseif notePos <= 12 then -- "Bad"
							score = score + 100
						else -- "Shit"
							if settings.kadeInput then
								success = false
							else
								score = score + 50
							end
						end

						table.remove(boyfriendNote, 1)

						if not settings.kadeInput or success then
							boyfriendArrow:animate("confirm", false)

							boyfriend:animate(curAnim, false)
							boyfriendFrameTimer = 0

							health = health + 1

							success = true
						end
					end
				end

				if not success then
					boyfriend:animate("miss " .. curAnim, false)
					boyfriendFrameTimer = 0

					health = health - 2
					score = score - 10
				end
			end

			if #boyfriendNote > 0 then
				if input:down(curInput) then
					if boyfriendNote[1].y - boyfriendNote[1].offsetY <= 20 and (boyfriendNote[1].anim.name == "hold" or boyfriendNote[1].anim.name == "end") then
						table.remove(boyfriendNote, 1)

						boyfriendArrow:animate("confirm", false)

						boyfriend:animate(curAnim, false)
						boyfriendFrameTimer = 0

						health = health + 2
					end
				end
			end

			if input:released(curInput) then
				boyfriendArrow:animate("off", false)
			end
		end

		if health > 100 then
			health = 100
		elseif health <= 0 then -- Game over, yeah!
			inst:stop()
			voices:stop()

			gameOver = true

			fakeBoyfriend:animate("dies", false)

			Timer.clear()
			Timer.tween(
				2,
				cam,
				{x = -50, y = -30}, -- Gross hack
				"out-quad",
				function()
					fakeBoyfriend:animate("dead", true)
				end
			)
		end

		enemyIcon.x = 250 - health * 2
		boyfriendIcon.x = 270 - health * 2

		if musicThres ~= oldMusicThres and math.fmod(musicTime, 60000 / bpm) < 100 then
			Timer.tween((60 / bpm) / 16, enemyIcon, {offsetX = -5}, "out-quad", function() Timer.tween((60 / bpm), enemyIcon, {offsetX = 0}, "out-quad") end)
			Timer.tween((60 / bpm) / 16, boyfriendIcon, {offsetX = -5}, "out-quad", function() Timer.tween((60 / bpm), boyfriendIcon, {offsetX = 0}, "out-quad") end)
		end

		if input:pressed("gameBack") then
			weeks[weekNum].stop()
		end
	end,

	draw = function()
		if not inGame then return end

		if gameOver then
			fakeBoyfriend:draw()

			return
		end
	end,

	drawUI = function()
		for i = 1, 4 do
			enemyArrows[i]:draw()
			boyfriendArrows[i]:draw()

			for j = #enemyNotes[i], 1, -1 do
				if enemyNotes[i][j].y - enemyNotes[i][j].offsetY <= 210 then
					enemyNotes[i][j]:draw()
				end
			end
			for j = #boyfriendNotes[i], 1, -1 do
				if boyfriendNotes[i][j].y - boyfriendNotes[i][j].offsetY <= 210 then
					boyfriendNotes[i][j]:draw()
				end
			end
		end

		love.graphics.setColor(255, 0, 0)
		love.graphics.rectangle("fill", 60, 170, 200, 5)
		love.graphics.setColor(0, 255, 0)
		love.graphics.rectangle("fill", 260 - health * 2, 170, 260 - (260 - health * 2), 5)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", 60, 170, 200, 5)
		love.graphics.setColor(255, 255, 255)

		boyfriendIcon:draw()
		enemyIcon:draw()

		love.graphics.print("Score: " .. score, 200, 180)
	end,

	stop = function()
		if inst then
			inst:stop()
		end
		voices:stop()

		Timer.clear()

		inMenu = true
		songNum = 0

		storyMode = false
		inGame = false

		menu.init()
	end
}
