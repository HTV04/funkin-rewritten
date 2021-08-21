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
