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
	love.graphics.newImage(graphics.imagePath("menu/storymenu/campaign_menu_UI_assets")),
    	-- Automatically generated from campaign_menu_UI_assets.xml
	{
		{x = 0, y = 0, width = 196, height = 65, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: EASY0000
		{x = 206, y = 0, width = 211, height = 67, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: HARD0000
		{x = 427, y = 0, width = 308, height = 67, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: NORMAL0000
		{x = 738, y = 374, width = 48, height = 85, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: arrow left0000
		{x = 796, y = 374, width = 42, height = 75, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: arrow push left0000
		{x = 848, y = 374, width = 41, height = 74, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: arrow push right0000
		{x = 899, y = 374, width = 47, height = 85, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: arrow right0000
		{x = 956, y = 374, width = 67, height = 93, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: lock0000
	},
    {
        ["easy"] = {start = 1, stop = 1, speed = 24, offsetX = 0, offsetY = 0},
        ["normal"] = {start = 3, stop = 3, speed = 24, offsetX = 0, offsetY = 0},
        ["hard"] = {start = 2, stop = 2, speed = 24, offsetX = 0, offsetY = 0},
        ["arrow left"] = {start = 4, stop = 4, speed = 24, offsetX = 0, offsetY = 0},
        ["arrow left confirm"] = {start = 5, stop = 5, speed = 24, offsetX = 0, offsetY = 0},
        ["arrow right"] = {start = 7, stop = 7, speed = 24, offsetX = 0, offsetY = 0},
        ["arrow right confirm"] = {start = 6, stop = 6, speed = 24, offsetX = 0, offsetY = 0},
        ["lock"] = {start = 8, stop = 8, speed = 24, offsetX = 0, offsetY = 0}
    },
    "normal",
    true
)