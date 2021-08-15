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

return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("week4/bg-limo")),
	-- Automatically generated from bgLimo.xml
	{
		{x = 0, y = 0, width = 2199, height = 379, offsetX = -19, offsetY = -5, offsetWidth = 2218, offsetHeight = 384}, -- 1: background limo pink0000
		{x = 0, y = 389, width = 2218, height = 380, offsetX = 0, offsetY = -4, offsetWidth = 2218, offsetHeight = 384}, -- 2: background limo pink0001
		{x = 0, y = 779, width = 2199, height = 384, offsetX = -19, offsetY = 0, offsetWidth = 2218, offsetHeight = 384}, -- 3: background limo pink0002
		{x = 0, y = 1173, width = 2199, height = 384, offsetX = -19, offsetY = 0, offsetWidth = 2218, offsetHeight = 384} -- 4: background limo pink0003
	},
	{
		["anim"] = {start = 1, stop = 4, speed = 24, offsetX = 0, offsetY = 0}
	},
	"anim",
	true
)
