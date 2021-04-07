--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

return Sprite (
	sheets["notes"],
	{
		{x = 0, y = 235, width = 157, height = 153, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowDOWN0000
		{x = 1850, y = 154, width = 157, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: blue0000
		{x = 1170, y = 447, width = 50, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: blue hold end0000
		{x = 1370, y = 449, width = 50, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: blue hold piece0000
		{x = 0, y = 0, width = 238, height = 235, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: down confirm0000
		{x = 238, y = 0, width = 238, height = 235, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: down confirm0001
		{x = 1176, y = 230, width = 219, height = 208, offsetX = -6, offsetY = -12, offsetWidth = 238, offsetHeight = 235}, -- 7: down confirm0002
		{x = 1176, y = 230, width = 219, height = 208, offsetX = -6, offsetY = -12, offsetWidth = 238, offsetHeight = 235}, -- 8: down confirm0003
		{x = 149, y = 392, width = 142, height = 140, offsetX = -4, offsetY = -2, offsetWidth = 149, offsetHeight = 146}, -- 9: down press0000
		{x = 149, y = 392, width = 142, height = 140, offsetX = -4, offsetY = -2, offsetWidth = 149, offsetHeight = 146}, -- 10: down press0001
		{x = 0, y = 388, width = 149, height = 146, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: down press0002
		{x = 0, y = 388, width = 149, height = 146, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 12: down press0003
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
