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
	love.graphics.newImage(graphics.imagePath("week2/haunted-house")),
	-- Automatically generated from halloween_bg.xml
	{
		{x = 0, y = 0, width = 2114, height = 1075, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: halloweem bg0000
		{x = 2124, y = 0, width = 2114, height = 1075, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 2: halloweem bg lightning strike0000
		{x = 4248, y = 0, width = 2114, height = 1000, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 3: halloweem bg lightning strike0001
		{x = 0, y = 1085, width = 2114, height = 1090, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: halloweem bg lightning strike0002
		{x = 2124, y = 1085, width = 2114, height = 1081, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 5: halloweem bg lightning strike0003
		{x = 4248, y = 1085, width = 2114, height = 1081, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 6: halloweem bg lightning strike0004
		{x = 4248, y = 1085, width = 2114, height = 1081, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 7: halloweem bg lightning strike0005
		{x = 0, y = 2185, width = 2114, height = 1081, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 8: halloweem bg lightning strike0006
		{x = 2124, y = 2185, width = 2114, height = 1081, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 9: halloweem bg lightning strike0007
		{x = 4248, y = 2185, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 10: halloweem bg lightning strike0008
		{x = 0, y = 3276, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 11: halloweem bg lightning strike0009
		{x = 2124, y = 3276, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 12: halloweem bg lightning strike0010
		{x = 4248, y = 3276, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 13: halloweem bg lightning strike0011
		{x = 0, y = 4366, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 14: halloweem bg lightning strike0012
		{x = 2124, y = 4366, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 15: halloweem bg lightning strike0013
		{x = 4248, y = 4366, width = 2114, height = 1080, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 16: halloweem bg lightning strike0014
		{x = 0, y = 5456, width = 2114, height = 1079, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 17: halloweem bg lightning strike0015
		{x = 2124, y = 5456, width = 2114, height = 1079, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 18: halloweem bg lightning strike0016
		{x = 4248, y = 5456, width = 2114, height = 1079, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 19: halloweem bg lightning strike0017
		{x = 0, y = 6545, width = 2114, height = 1079, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 20: halloweem bg lightning strike0018
		{x = 2124, y = 6545, width = 2114, height = 1078, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 21: halloweem bg lightning strike0019
		{x = 4248, y = 6545, width = 2114, height = 1078, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1090}, -- 22: halloweem bg lightning strike0020
		{x = 0, y = 0, width = 2114, height = 1075, offsetX = 0, offsetY = 0, offsetWidth = 2114, offsetHeight = 1091} -- 23: halloweem bg lightning strike0029 -- Fixed
	},
	{
		["normal"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["lightning"] = {start = 2, stop = 23, speed = 24, offsetX = 0, offsetY = -8}
	},
	"normal",
	false
)
