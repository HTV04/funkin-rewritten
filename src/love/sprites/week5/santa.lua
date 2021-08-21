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
	love.graphics.newImage(graphics.imagePath("week5/santa")),
	-- Automatically generated from santa.xml
	{
		{x = 0, y = 0, width = 663, height = 722, offsetX = 0, offsetY = -25, offsetWidth = 663, offsetHeight = 748}, -- 1: santa idle in fear0000
		{x = 673, y = 0, width = 662, height = 722, offsetX = -1, offsetY = -25, offsetWidth = 663, offsetHeight = 748}, -- 2: santa idle in fear0001
		{x = 1345, y = 0, width = 658, height = 724, offsetX = -3, offsetY = -24, offsetWidth = 663, offsetHeight = 748}, -- 3: santa idle in fear0002
		{x = 2013, y = 0, width = 658, height = 723, offsetX = -3, offsetY = -24, offsetWidth = 663, offsetHeight = 748}, -- 4: santa idle in fear0003
		{x = 2681, y = 0, width = 650, height = 732, offsetX = -7, offsetY = -16, offsetWidth = 663, offsetHeight = 748}, -- 5: santa idle in fear0004
		{x = 3341, y = 0, width = 650, height = 732, offsetX = -7, offsetY = -16, offsetWidth = 663, offsetHeight = 748}, -- 6: santa idle in fear0005
		{x = 0, y = 742, width = 650, height = 735, offsetX = -7, offsetY = -13, offsetWidth = 663, offsetHeight = 748}, -- 7: santa idle in fear0006
		{x = 660, y = 742, width = 650, height = 735, offsetX = -7, offsetY = -13, offsetWidth = 663, offsetHeight = 748}, -- 8: santa idle in fear0007
		{x = 1320, y = 742, width = 650, height = 747, offsetX = -7, offsetY = -1, offsetWidth = 663, offsetHeight = 748}, -- 9: santa idle in fear0008
		{x = 1980, y = 742, width = 650, height = 748, offsetX = -7, offsetY = 0, offsetWidth = 663, offsetHeight = 748}, -- 10: santa idle in fear0009
		{x = 2640, y = 742, width = 650, height = 748, offsetX = -7, offsetY = 0, offsetWidth = 663, offsetHeight = 748}, -- 11: santa idle in fear0010
		{x = 3300, y = 742, width = 650, height = 748, offsetX = -7, offsetY = 0, offsetWidth = 663, offsetHeight = 748}, -- 12: santa idle in fear0011
		{x = 1980, y = 742, width = 650, height = 748, offsetX = -7, offsetY = 0, offsetWidth = 663, offsetHeight = 748}, -- 13: santa idle in fear0012
		{x = 2640, y = 742, width = 650, height = 748, offsetX = -7, offsetY = 0, offsetWidth = 663, offsetHeight = 748} -- 14: santa idle in fear0013
	},
	{
		["anim"] = {start = 1, stop = 14, speed = 24, offsetX = 0, offsetY = 0}
	},
	"anim",
	false
)
