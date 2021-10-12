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
		{x = 310, y = 235, width = 153, height = 157, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowLEFT0000
		{x = 948, y = 0, width = 228, height = 231, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: left confirm0000
		{x = 1402, y = 228, width = 218, height = 221, offsetX = -5, offsetY = -5, offsetWidth = 228, offsetHeight = 231}, -- 3: left confirm0001
		{x = 1402, y = 0, width = 225, height = 221, offsetX = -2, offsetY = -1, offsetWidth = 228, offsetHeight = 231}, -- 4: left confirm0002
		{x = 1402, y = 0, width = 225, height = 221, offsetX = -2, offsetY = -1, offsetWidth = 228, offsetHeight = 231}, -- 5: left confirm0003
		{x = 291, y = 392, width = 140, height = 142, offsetX = -3, offsetY = -3, offsetWidth = 146, offsetHeight = 149}, -- 6: left press0000
		{x = 291, y = 392, width = 140, height = 142, offsetX = -3, offsetY = -3, offsetWidth = 146, offsetHeight = 149}, -- 7: left press0001
		{x = 463, y = 389, width = 146, height = 149, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: left press0002
		{x = 463, y = 389, width = 146, height = 149, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: left press0003
		{x = 1220, y = 447, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: pruple end hold0000
		{x = 630, y = 232, width = 154, height = 157, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: purple0000
		{x = 1420, y = 449, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 12: purple hold piece0000
	},
	{
		["off"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 2, stop = 5, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 6, stop = 9, speed = 24, offsetX = 0, offsetY = 0},
		["end"] = {start = 10, stop = 10, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 11, stop = 11, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 12, stop = 12, speed = 0, offsetX = 0, offsetY = 0}
	},
	"off",
	false
)
