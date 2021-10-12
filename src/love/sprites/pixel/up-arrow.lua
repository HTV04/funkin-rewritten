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
		{x = 36, y = 0, width = 17, height = 17, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Up Arrow
		{x = 36, y = 18, width = 17, height = 17, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Up Arrow On
		{x = 36, y = 36, width = 17, height = 17, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: Up Arrow Press
		{x = 36, y = 54, width = 17, height = 17, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: Up Arrow Confirm 1
		{x = 36, y = 72, width = 17, height = 17, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: Up Arrow Confirm 2
		{x = 16, y = 89, width = 7, height = 6, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: Up Hold
		{x = 16, y = 97, width = 7, height = 6, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 7: Up End
	},
	{
		["off"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["press"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 4, stop = 5, speed = 24, offsetX = 0, offsetY = 0},
		["hold"] = {start = 6, stop = 6, speed = 0, offsetX = 0, offsetY = 0},
		["end"] = {start = 7, stop = 7, speed = 0, offsetX = 0, offsetY = 0}
	},
	"off",
	false,
	{
		floored = true
	}
)
