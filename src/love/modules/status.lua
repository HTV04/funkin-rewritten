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

local loading

local noResize

return {
	setLoading = function(state)
		loading = state
	end,
	getLoading = function()
		return loading
	end,

	setNoResize = function(state)
		noResize = state
	end,
	getNoResize = function(state)
		return noResize
	end,

	getDebugStr = function(type)
		local debugStr

		if type == "detailed" then
			debugStr = "FPS: " .. tostring(love.timer.getFPS()) ..
			"\nLUA MEM USAGE (KB): " .. tostring(math.floor(collectgarbage("count"))) ..
			"\nGRAPHICS MEM USAGE (MB): " .. tostring(math.floor(love.graphics.getStats().texturememory / 1048576)) ..

			"\n\nsettings.hardwareCompression: " .. tostring(settings.hardwareCompression) ..
			"\ngraphics.getImageType(): " .. tostring(graphics.getImageType()) ..

			"\n\nmusicTime: " .. tostring(math.floor(musicTime)) ..  -- Floored for readability
			"\nhealth: " .. tostring(health)
		else
			debugStr = "FPS: " .. tostring(love.timer.getFPS())
		end

		return debugStr
	end
}
