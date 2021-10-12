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
		{x = 157, y = 235, width = 153, height = 157, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowRIGHT0000
		{x = 476, y = 232, width = 154, height = 157, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: red0000
		{x = 1070, y = 442, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: red hold end0000
		{x = 1270, y = 447, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: red hold piece0000
		{x = 1627, y = 0, width = 223, height = 226, offsetX = -1, offsetY = -3, offsetWidth = 226, offsetHeight = 230}, -- 5: right confirm0000
		{x = 1627, y = 226, width = 223, height = 226, offsetX = -1, offsetY = -3, offsetWidth = 226, offsetHeight = 230}, -- 6: right confirm0001
		{x = 1176, y = 0, width = 226, height = 230, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: right confirm0002
		{x = 1176, y = 0, width = 226, height = 230, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: right confirm0003
		{x = 932, y = 442, width = 138, height = 141, offsetX = -3, offsetY = -7, offsetWidth = 148, offsetHeight = 151}, -- 9: right press0000
		{x = 932, y = 442, width = 138, height = 141, offsetX = -3, offsetY = -7, offsetWidth = 148, offsetHeight = 151}, -- 10: right press0001
		{x = 784, y = 385, width = 148, height = 151, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: right press0002
		{x = 784, y = 385, width = 148, height = 151, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 12: right press0003
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
