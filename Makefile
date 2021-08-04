# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Makefile v1.2-switch
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
	@mkdir -p build/lovefile-switch/switch
	
	@cd src/love; zip -r -9 ../../build/lovefile-switch/switch/funkin-rewritten.love .

switch: lovefile-switch
	@rm -rf build/switch
	@mkdir -p build/switch/switch/funkin-rewritten
	
	@elf2nro resources/switch/LOVEPotion.elf build/switch/switch/funkin-rewritten/funkin-rewritten.nro --icon=resources/switch/icon.jpg --nacp=resources/switch/funkin-rewritten.nacp --romfsdir=resources/switch/romfs
	
	@cat build/lovefile-switch/switch/funkin-rewritten.love >> build/switch/switch/funkin-rewritten/funkin-rewritten.nro

release: lovefile-switch switch
	@mkdir -p build/release
	
	@rm -f build/release/funkin-rewritten-lovefile-switch.zip
	@rm -f build/release/funkin-rewritten-switch.zip
	
	@cd build/lovefile-switch; zip -9 -r ../release/funkin-rewritten-lovefile-switch.zip .
	@cd build/switch; zip -9 -r ../release/funkin-rewritten-switch.zip .

clean:
	@rm -rf build
