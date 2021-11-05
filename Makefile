# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Makefile v1.3-switch
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
	@rm -rf build/lovefile-switch-old
	@mkdir -p build/lovefile-switch-old/switch

	@cd src/love; zip -r -9 ../../build/lovefile-switch-old/switch/funkin-rewritten.love .

switch: lovefile-switch
	@rm -rf build/switch-old
	@mkdir -p build/switch-old/switch/funkin-rewritten

	@nacptool --create "Friday Night Funkin' Rewritten" HTV04 "$(shell cat version.txt)" build/switch-old/funkin-rewritten.nacp
	@elf2nro resources/switch-old/LOVEPotion.elf build/switch-old/switch/funkin-rewritten/funkin-rewritten.nro --icon=resources/switch-old/icon.jpg --nacp=build/switch-old/funkin-rewritten.nacp --romfsdir=resources/switch-old/romfs

	@cat build/lovefile-switch-old/switch/funkin-rewritten.love >> build/switch-old/switch/funkin-rewritten/funkin-rewritten.nro

	@rm build/switch-old/funkin-rewritten.nacp

release: lovefile-switch switch
	@mkdir -p build/release

	@rm -f build/release/funkin-rewritten-lovefile-switch-old.zip
	@rm -f build/release/funkin-rewritten-switch-old.zip

	@cd build/lovefile-switch-old; zip -9 -r ../release/funkin-rewritten-lovefile-switch-old.zip .
	@cd build/switch-old; zip -9 -r ../release/funkin-rewritten-switch-old.zip .

clean:
	@rm -rf build
