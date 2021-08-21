--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

return graphics.newSprite(
	images["icons"],
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
	false,
	{
		floored = true
	}
)
