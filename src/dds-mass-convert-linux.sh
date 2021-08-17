#!/usr/bin/env bash

# --------------------------------------------------------------------------------
# Friday Night Funkin' Rewritten DDS Mass Conversion Script for Linux v1.1
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

cd love/images/png # "Base images" directory

rm -rf ../dds
mkdir ../dds

printf "%s\n" "Converting..."

for d in $(find . ! -path . -type d | cut -c3-)
do
	rm -rf ../dds/$d
	mkdir -p ../dds/$d
	
	for f in $(find $d -maxdepth 1 -name "*.png" -type f | cut -c3-)
	do
		mogrify -define dds:cluster-fit=true -define dds:compression=dxt5 -define dds:mipmaps=0 -format dds -monitor -path ../dds/$d $d/$f
	done
done
for f in $(find . -maxdepth 1 -name "*.png" -type f | cut -c3-)
do
	mogrify -define dds:cluster-fit=true -define dds:compression=dxt5 -define dds:mipmaps=0 -format dds -monitor -path ../dds $f
done

printf "\n"
