#!/usr/bin/env python3

# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Legacy JSON Converter v1.0
# By HTV04
# --------------------------------------------------------------------------------

import json
import sys

jsonfile = sys.argv[1]

with open(jsonfile) as f:
    jsondata = f.read()

songdata = json.loads(jsondata.strip('\x00'))

notes = songdata['song']['notes']
arguments = ['mustHitSection', 'bpm', 'altAnim']
lua = ('-- Automatically generated from ' + jsonfile + '\n'
       'return {\n'
       '\tspeed = ' + str(songdata['song']['speed']) + ',\n')
for i in notes:
    lua += '\t{\n'
    for j in arguments:
        if j in i:
            lua += '\t\t' + j + ' = ' + str(i[j]).lower() + ',\n'
    if len(i['sectionNotes']) > 0:
        lua += '        sectionNotes = {\n'
        for j in i['sectionNotes']:
            lua += ('\t\t\t{\n'
                    '\t\t\t\tnoteTime = ' + str(j[0]) + ',\n'
                    '\t\t\t\tnoteType = ' + str(j[1]) + ',\n'
                    '\t\t\t\tnoteLength = ' + str(j[2]) + '\n'
                    '\t\t\t},\n')
        lua = (lua[:len(lua) - 3] + '}\n'
               '\t\t}\n')
    else:
        lua += '\t\tsectionNotes = {}\n'
    lua += '\t},\n'

lua = (lua[:len(lua) - 3] + '}\n'
        '}\n')

with open(jsonfile[:len(jsonfile) - 4] + 'lua', 'w') as f:
    f.write(lua)
