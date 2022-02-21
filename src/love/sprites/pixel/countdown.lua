return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("pixel/countdown")),
	{
		{x = 0, y = 0, width = 87, height = 41, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Ready
		{x = 87, y = 0, width = 80, height = 37, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Set
		{x = 167, y = 0, width = 97, height = 37, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: Date
	},
	{
		["ready"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["set"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["date"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0}
	},
	"ready",
	false
)
