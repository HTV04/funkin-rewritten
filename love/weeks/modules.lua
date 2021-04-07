--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

audio = {
	playSound = function(sound)
		sound:stop()
		sound:play()
	end
}

graphics = {
	fade = {1}, -- Have to make this a table for "Timer.tween"
	
	fadeOut = function(duration, func)
		if graphics.fadeTimer then
			Timer.cancel(graphics.fadeTimer)
		end
		
		graphics.fadeTimer = Timer.tween(duration, graphics.fade, {0}, "linear", func)
	end,
	
	fadeIn = function(duration, func)
		if graphics.fadeTimer then
			Timer.cancel(graphics.fadeTimer)
		end
		
		graphics.fadeTimer = Timer.tween(duration, graphics.fade, {1}, "linear", func)
	end,
	
	setColor = function(r, g, b, a)
		local fade = graphics.fade[1]
		
		love.graphics.setColor(fade * r, fade * g, fade * b, a)
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
		left = {"key:left", "axis:leftx-", "button:dpleft"},
		down = {"key:down", "axis:lefty+", "button:dpdown"},
		up = {"key:up", "axis:lefty-", "button:dpup"},
		right = {"key:right", "axis:leftx+", "button:dpright"},
		confirm = {"key:return", "button:a"},
		back = {"key:escape", "button:b"},
		
		gameLeft = {"key:a", "key:left", "axis:triggerleft+", "axis:leftx-", "axis:rightx-", "button:dpleft", "button:x"},
		gameDown = {"key:s", "key:down", "axis:lefty+", "axis:righty+", "button:leftshoulder", "button:dpdown", "button:a"},
		gameUp = {"key:w", "key:up", "axis:lefty-", "axis:righty-", "button:rightshoulder", "button:dpup", "button:y"},
		gameRight = {"key:d", "key:right", "axis:triggerright+", "axis:leftx+", "axis:rightx+", "button:dpright", "button:b"},
		gameBack = {"key:escape", "button:start"},
	},
	joystick = love.joystick.getJoysticks()[1]
}
