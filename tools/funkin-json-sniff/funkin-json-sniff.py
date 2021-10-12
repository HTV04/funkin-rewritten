#!/usr/bin/env python3

# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Legacy JSON Converter (for SNIFF) v1.2
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

import json
import os
import sys

for i in range(1, len(sys.argv)):
    jsonfile = os.path.split(sys.argv[i])[1]

    with open(jsonfile) as f:
        jsondata = f.read()

    songdata = json.loads(jsondata)

    notes = songdata['song']['notes']
    arguments = ['mustHitSection', 'altAnim']
    lua = ('-- Automatically generated from ' + jsonfile + '\n'
           'return {\n'
           '\tspeed = ' + str(songdata['song']['speed']) + ',\n')
    noBpm = True
    for j in notes:
        lua += '\t{\n'
        for k in arguments:
            if k in j:
                if k == 'mustHitSection':
                    lua += '\t\tmustHitSection = ' + str(j['mustHitSection']).lower() + ',\n'

                    if noBpm:
                        lua += '\t\tbpm = ' + str(songdata['song']['bpm']) + ',\n'

                        noBpm = False
                else:
                    lua += '\t\t' + k + ' = ' + str(j[k]).lower() + ',\n'
        if noBpm:
            lua += '\t\tbpm = ' + str(songdata['song']['bpm']) + ',\n'

            noBpm = False
        if len(j['sectionNotes']) > 0:
            lua += '\t\tsectionNotes = {\n'
            for k in j['sectionNotes']:
                lua += ('\t\t\t{\n'
                        '\t\t\t\tnoteTime = ' + str(k[0]) + ',\n'
                        '\t\t\t\tnoteType = ' + str(k[1]) + ',\n'
                        '\t\t\t\tnoteLength = ' + str(k[2]) + '\n'
                        '\t\t\t},\n')
            lua = (lua[:len(lua) - 3] + '}\n'
                   '\t\t}\n')
        else:
            lua += '\t\tsectionNotes = {}\n'
        lua += '\t},\n'

    lua = (lua[:len(lua) - 3] + '}\n'
            '}\n')

    with open(os.path.splitext(jsonfile)[0] + '.lua', 'w') as f:
        f.write(lua)
