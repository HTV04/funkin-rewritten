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
	love.graphics.newImage(graphics.imagePath("menu/FNF_main_menu_assets")),
    	-- Automatically generated from FNF_main_menu_assets.xml
	{
		{x = 0, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: donate basic0000
		{x = 0, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: donate basic0001
		{x = 0, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: donate basic0002
		{x = 454, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: donate basic0003
		{x = 454, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: donate basic0004
		{x = 454, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: donate basic0005
		{x = 908, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: donate basic0006
		{x = 908, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: donate basic0007
		{x = 908, y = 0, width = 444, height = 117, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: donate basic0008
		{x = 1362, y = 0, width = 590, height = 157, offsetX = 0, offsetY = -2, offsetWidth = 590, offsetHeight = 159}, -- 10: donate white0000
		{x = 0, y = 167, width = 587, height = 154, offsetX = -1, offsetY = -5, offsetWidth = 590, offsetHeight = 159}, -- 11: donate white0001
		{x = 597, y = 167, width = 585, height = 155, offsetX = -3, offsetY = 0, offsetWidth = 590, offsetHeight = 159}, -- 12: donate white0002
		{x = 1192, y = 167, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: freeplay basic0000
		{x = 1192, y = 167, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: freeplay basic0001
		{x = 1192, y = 167, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: freeplay basic0002
		{x = 0, y = 332, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: freeplay basic0003
		{x = 0, y = 332, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: freeplay basic0004
		{x = 0, y = 332, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: freeplay basic0005
		{x = 494, y = 332, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: freeplay basic0006
		{x = 494, y = 332, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: freeplay basic0007
		{x = 494, y = 332, width = 484, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: freeplay basic0008
		{x = 988, y = 332, width = 627, height = 169, offsetX = 0, offsetY = 0, offsetWidth = 635, offsetHeight = 174}, -- 22: freeplay white0000
		{x = 0, y = 511, width = 632, height = 170, offsetX = -3, offsetY = -1, offsetWidth = 635, offsetHeight = 174}, -- 23: freeplay white0001
		{x = 642, y = 511, width = 629, height = 173, offsetX = -4, offsetY = -1, offsetWidth = 635, offsetHeight = 174}, -- 24: freeplay white0002
		{x = 1281, y = 511, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 25: options basic0000
		{x = 1281, y = 511, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 26: options basic0001
		{x = 1281, y = 511, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 27: options basic0002
		{x = 0, y = 694, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 28: options basic0003
		{x = 0, y = 694, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 29: options basic0004
		{x = 0, y = 694, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 30: options basic0005
		{x = 497, y = 694, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 31: options basic0006
		{x = 497, y = 694, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 32: options basic0007
		{x = 497, y = 694, width = 487, height = 111, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 33: options basic0008
		{x = 994, y = 694, width = 606, height = 155, offsetX = -2, offsetY = -1, offsetWidth = 610, offsetHeight = 163}, -- 34: options white0000
		{x = 0, y = 859, width = 607, height = 158, offsetX = -3, offsetY = -1, offsetWidth = 610, offsetHeight = 163}, -- 35: options white0001
		{x = 617, y = 859, width = 610, height = 163, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 36: options white0002
		{x = 1237, y = 859, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 37: story mode basic0000
		{x = 1237, y = 859, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 38: story mode basic0001
		{x = 1237, y = 859, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 39: story mode basic0002
		{x = 0, y = 1032, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 40: story mode basic0003
		{x = 0, y = 1032, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 41: story mode basic0004
		{x = 0, y = 1032, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 42: story mode basic0005
		{x = 625, y = 1032, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 43: story mode basic0006
		{x = 625, y = 1032, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 44: story mode basic0007
		{x = 625, y = 1032, width = 615, height = 122, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 45: story mode basic0008
		{x = 1250, y = 1032, width = 796, height = 173, offsetX = 0, offsetY = -3, offsetWidth = 796, offsetHeight = 181}, -- 46: story mode white0000
		{x = 0, y = 1215, width = 794, height = 174, offsetX = -2, offsetY = -2, offsetWidth = 796, offsetHeight = 181}, -- 47: story mode white0001
		{x = 804, y = 1215, width = 794, height = 181, offsetX = 0, offsetY = 0, offsetWidth = 796, offsetHeight = 181} -- 48: story mode white0002
	},
    {
        ["donate"] = {start = 1, stop = 9, speed = 24, offsetX = 0, offsetY = 0}, -- you can change this to what you want
        ["donate hover"] = {start = 10, stop = 12, speed = 24, offsetX = 0, offsetY = 0}, -- you can change this to what you want
        ["freeplay"] = {start = 13, stop = 21, speed = 24, offsetX = 0, offsetY = 0},
        ["freeplay hover"] = {start = 22, stop = 24, speed = 24, offsetX = 0, offsetY = 0},
        ["options"] = {start = 25, stop = 33, speed = 24, offsetX = 0, offsetY = 0},
        ["options hover"] = {start = 34, stop = 36, speed = 24, offsetX = 0, offsetY = 0},
        ["story"] = {start = 37, stop = 45, speed = 24, offsetX = 0, offsetY = 0},
        ["story hover"] = {start = 46, stop = 48, speed = 24, offsetX = 0, offsetY = 0}
    },
    "story",
    true

)