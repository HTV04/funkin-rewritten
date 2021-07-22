# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Makefile v1.1-switch
# 
# Copyright (C) 2021  HTV04
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# --------------------------------------------------------------------------------

lovefile-switch:
	@rm -rf build/lovefile-switch
	@mkdir -p build/lovefile-switch
	
	@cd src/love; zip -r -9 ../../build/lovefile-switch/funkin-rewritten.love .

switch:
	@rm -rf build/switch
	@mkdir -p build/switch/funkin-rewritten/save
	
	@~/.local/bin/lovebrew
	
	@rm -rf build/switch/romfs build/switch/funkin-rewritten.nacp build/switch/game.love
	@mv build/switch/funkin-rewritten.nro build/switch/funkin-rewritten
	@cp -r resources/lovepotion-save/. build/switch/funkin-rewritten/save

release: lovefile-switch switch
	@mkdir -p build/release
	
	@rm -f build/release/funkin-rewritten-lovefile-switch.zip
	@rm -f build/release/funkin-rewritten-switch.zip
	
	@cd build/lovefile-switch; zip -9 -r ../release/funkin-rewritten-lovefile-switch.zip .
	@cd build/switch; zip -9 -r ../release/funkin-rewritten-switch.zip .

clean:
	@rm -rf build
