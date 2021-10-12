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
	images.notes,
	{
		{x = 784, y = 232, width = 157, height = 153, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowUP0000
		{x = 1850, y = 0, width = 157, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: green0000
		{x = 1120, y = 442, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: green hold end0000
		{x = 1320, y = 447, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: green hold piece0000
		{x = 476, y = 0, width = 236, height = 232, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: up confirm0000
		{x = 712, y = 0, width = 236, height = 232, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: up confirm0001
		{x = 948, y = 231, width = 214, height = 206, offsetX = -11, offsetY = -10, offsetWidth = 236, offsetHeight = 232}, -- 7: up confirm0002
		{x = 948, y = 231, width = 214, height = 206, offsetX = -11, offsetY = -10, offsetWidth = 236, offsetHeight = 232}, -- 8: up confirm0003
		{x = 609, y = 389, width = 144, height = 141, offsetX = -5, offsetY = -4, offsetWidth = 153, offsetHeight = 150}, -- 9: up press0000
		{x = 609, y = 389, width = 144, height = 141, offsetX = -5, offsetY = -4, offsetWidth = 153, offsetHeight = 150}, -- 10: up press0001
		{x = 1850, y = 308, width = 153, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: up press0002
		{x = 1850, y = 308, width = 153, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 12: up press0003
	},
	{
		["off"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["end"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 5, stop = 8, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 9, stop = 12, speed = 24, offsetX = 0, offsetY = 0}
	},
	"off",
	false
)
