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
	images["numbers"],
	{
		{x = 0, y = 0, width = 9, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: 0
		{x = 10, y = 0, width = 9, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: 1
		{x = 20, y = 0, width = 10, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: 2
		{x = 31, y = 0, width = 10, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: 3
		{x = 42, y = 0, width = 10, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: 4
		{x = 53, y = 0, width = 10, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: 5
		{x = 64, y = 0, width = 10, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: 6
		{x = 75, y = 0, width = 9, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: 7
		{x = 85, y = 0, width = 9, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: 8
        {x = 95, y = 0, width = 9, height = 12, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: 9
    },
	{
		["0"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
        ["1"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
        ["2"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
        ["3"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
        ["4"] = {start = 5, stop = 5, speed = 0, offsetX = 0, offsetY = 0},
        ["5"] = {start = 6, stop = 6, speed = 0, offsetX = 0, offsetY = 0},
        ["6"] = {start = 7, stop = 7, speed = 0, offsetX = 0, offsetY = 0},
        ["7"] = {start = 8, stop = 8, speed = 0, offsetX = 0, offsetY = 0},
        ["8"] = {start = 9, stop = 9, speed = 0, offsetX = 0, offsetY = 0},
        ["9"] = {start = 10, stop = 10, speed = 0, offsetX = 0, offsetY = 0}
    },
	"0",
	false,
    {
		floored = true
	}
)
