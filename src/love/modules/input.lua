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

return baton.new {
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
