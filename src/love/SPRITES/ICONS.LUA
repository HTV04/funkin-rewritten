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

return Sprite (
	sheets["icons"],
	{
		{x = 0, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend
		{x = 30, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Senpai
		{x = 60, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 3: Spirit
	},
	{
		["boyfriend"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["senpai"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["spirit"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0}
	},
	"boyfriend",
	false
)
