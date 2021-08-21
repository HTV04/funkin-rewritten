#!/usr/bin/env python3

# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Legacy XNA Conversion Helper v1.1
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

import re
import os
import sys

txtname = os.path.split(sys.argv[1])[1]
with open(sys.argv[1], "r") as f:
    txtlines = f.readlines()

lua = ('\t-- Automatically generated from ' + txtname + '\n'
       '\t{\n')
c = 0
for txtline in txtlines:
    c += 1
    parsedline = re.match(r'(.+) = (\d+) (\d+) (\d+) (\d+)', txtline)

    name = parsedline.group(1)
    x = parsedline.group(2)
    y = parsedline.group(3)
    width = parsedline.group(4)
    height = parsedline.group(5)

    lua += '\t\t{x = ' + x + ', y = ' + y + ', width = ' + width + ', height = ' + height + ', offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- ' + str(c) + ': ' + name + '\n'

lua = lua[:len(lua) - (len(str(c)) + len(name) + 9)] + '} -- ' + str(c) + ': ' + name + '\n'
lua += '\t},\n'

with open('output.txt', 'w') as f:
    f.write(lua)
