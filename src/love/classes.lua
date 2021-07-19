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

Image = Class {
	init = function(self, image)
		self.x = 0
		self.y = 0
		self.oreintation = 0
		self.sizeX = 1
		self.sizeY = 1
		self.offsetX = 0
		self.offsetY = 0
		self.shearX = 0
		self.shearY = 0
		
		self.image = image
		self.width = self.image:getWidth()
		self.height = self.image:getHeight()
	end,
	draw = function(self)
		love.graphics.draw(
			self.image,
			self.x,
			self.y,
			self.orientation,
			self.sizeX,
			self.sizeY,
			self.width / 2 + self.offsetX,
			self.height / 2 + self.offsetY,
			self.shearX,
			self.shearY
		)
	end
}

Sprite = Class {
	init = function(self, sheet, frameData, anims, anim, loopAnim)
		self.frames = {}
		self.currentFrame = 1
		self.x = 0
		self.y = 0
		self.orientation = 0
		self.sizeX = 1
		self.sizeY = 1
		self.offsetX = 0
		self.offsetY = 0
		self.shearX = 0
		self.shearY = 0
		
		self.sheet = sheet
		self.sheetData = {width = self.sheet:getWidth(), height = self.sheet:getHeight()}
		self.frameData = frameData
		for i = 1, #self.frameData do
			table.insert(
				self.frames,
				love.graphics.newQuad(
					self.frameData[i].x,
					self.frameData[i].y,
					self.frameData[i].width,
					self.frameData[i].height,
					self.sheetData.width,
					self.sheetData.height
				)
			)
		end
		self.anims = anims
		
		self:animate(anim, loopAnim)
	end,
	update = function(self, dt)
		if self.animated then
			self.currentFrame = self.currentFrame + self.anim.speed * dt
		end
		
		if self.animated and self.currentFrame > self.anim.stop then
			if self.loopAnim then
				self.currentFrame = self.anim.start
			else
				self.animated = false
			end
		end
	end,
	animate = function(self, anim, loopAnim)
		self.anim = {
			name = anim,
			start = self.anims[anim].start,
			stop = self.anims[anim].stop,
			speed = self.anims[anim].speed,
			offsetX = self.anims[anim].offsetX,
			offsetY = self.anims[anim].offsetY
		}
		self.currentFrame = self.anim.start
		self.loopAnim = loopAnim
		
		self.animated = true
	end,
	draw = function(self)
		local currentFrame = math.floor(self.currentFrame)
		
		if currentFrame <= self.anim.stop then
			local width, height
			
			if self.frameData[currentFrame].offsetWidth == 0 then
				width = self.frameData[currentFrame].width / 2
			else
				width = self.frameData[currentFrame].offsetWidth / 2 + self.frameData[currentFrame].offsetX
			end
			if self.frameData[currentFrame].offsetHeight == 0 then
				height = self.frameData[currentFrame].height / 2
			else
				height = self.frameData[currentFrame].offsetHeight / 2 + self.frameData[currentFrame].offsetY
			end
			
			love.graphics.draw(
				self.sheet,
				self.frames[currentFrame],
				self.x,
				self.y,
				self.orientation,
				self.sizeX,
				self.sizeY,
				width + self.anim.offsetX + self.offsetX,
				height + self.anim.offsetY + self.offsetY,
				self.shearX,
				self.shearY
			)
		end
	end
}
