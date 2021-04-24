#!/usr/bin/env python3

# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten Legacy XML Conversion Helper v1.1
# By HTV04
# --------------------------------------------------------------------------------

import os
import sys

import xml.etree.ElementTree as ET

xmlname = os.path.split(sys.argv[1])[1]
sheetxml = ET.parse(xmlname).getroot()

lua = ('\t-- Automatically generated from ' + xmlname + '\n'
       '\t{\n')
c = 0
for SubTexture in sheetxml.findall('SubTexture'):
    c += 1
    
    name = SubTexture.get('name')
    x = SubTexture.get('x')
    y = SubTexture.get('y')
    width = SubTexture.get('width')
    height = SubTexture.get('height')
    offsetx = SubTexture.get('frameX')
    offsety = SubTexture.get('frameY')
    offsetWidth = SubTexture.get('frameWidth')
    offsetHeight = SubTexture.get('frameHeight')
    
    if offsetx is None:
        offsetx = '0'
    if offsety is None:
        offsety = '0'
    if offsetWidth is None:
        offsetWidth = '0'
    if offsetHeight is None:
        offsetHeight = '0'
    
    lua += '\t\t{x = ' + x + ', y = ' + y + ', width = ' + width + ', height = ' + height + ', offsetX = ' + offsetx + ', offsetY = ' + offsety + ', offsetWidth = ' + offsetWidth + ', offsetHeight = ' + offsetHeight + '}, -- ' + str(c) + ': ' + name + '\n'

lua = lua[:len(lua) - (len(str(c)) + len(name) + 9)] + '} -- ' + str(c) + ': ' + name + '\n'
lua += '\t},\n'

with open('output.txt', 'w') as f:
    f.write(lua)
