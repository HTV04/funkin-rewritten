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

audio = {
	playSound = function(sound)
		sound:stop()
		sound:play()
	end
}

graphics = {
	imageType = "png",
	fade = {1}, -- Have to make this a table for "Timer.tween"
	isFading = false,
	
	imagePath = function(path)
		return "images/" .. graphics.imageType .. "/" .. path .. "." .. graphics.imageType
	end,
	
	fadeOut = function(duration, func)
		if graphics.fadeTimer then
			Timer.cancel(graphics.fadeTimer)
		end
		
		graphics.isFading = true
		graphics.fadeTimer = Timer.tween(
			duration,
			graphics.fade,
			{0},
			"linear",
			function()
				graphics.isFading = false
				
				if func then func() end
			end
		)
	end,
	
	fadeIn = function(duration, func)
		if graphics.fadeTimer then
			Timer.cancel(graphics.fadeTimer)
		end
		
		graphics.isFading = true
		graphics.fadeTimer = Timer.tween(
			duration,
			graphics.fade,
			{1},
			"linear",
			function()
				graphics.isFading = false
				
				if func then func() end
			end
		)
	end,
	
	cancelTimer = function()
		if graphics.fadeTimer then
			Timer.cancel(graphics.fadeTimer)
			
			graphics.isFading = false
		end
	end,
	
	clear = function(r, g, b, a, s, d)
		local fade = graphics.fade[1]
		
		love.graphics.clear(fade * r, fade * g, fade * b, a, s, d)
	end,
	
	setColor = function(r, g, b, a)
		local fade = graphics.fade[1]
		
		love.graphics.setColor(fade * r, fade * g, fade * b, a)
	end,
	
	setBackgroundColor = function(r, g, b, a)
		local fade = graphics.fade[1]
		
		love.graphics.setBackgroundColor(fade * r, fade * g, fade * b, a)
	end,
	
	getColor = function()
		local r, g, b, a
		
		local fade = graphics.fade[1]
		
		r, g, b, a = love.graphics.getColor()
		
		return r / fade, g / fade, b / fade, a
	end
}

input = baton.new {
	controls = {
		left = {"axis:leftx-", "button:dpleft"},
		down = {"axis:lefty+", "button:dpdown"},
		up = {"axis:lefty-", "button:dpup"},
		right = {"axis:leftx+", "button:dpright"},
		confirm = {"button:a"},
		back = {"button:b"},
		
		gameLeft = {"axis:triggerleft+", "axis:leftx-", "axis:rightx-", "button:dpleft", "button:y"},
		gameDown = {"axis:lefty+", "axis:righty+", "button:leftshoulder", "button:dpdown", "button:b"},
		gameUp = {"axis:lefty-", "axis:righty-", "button:rightshoulder", "button:dpup", "button:x"},
		gameRight = {"axis:triggerright+", "axis:leftx+", "axis:rightx+", "button:dpright", "button:a"},
		gameBack = {"button:start"},
	},
	joystick = love.joystick.getJoysticks()[1]
}
