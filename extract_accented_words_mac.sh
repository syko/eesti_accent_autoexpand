#!/bin/bash

# Find words with accented characters in them and cap the number
cut -d ' ' -f1 words/et-full-frequency.txt | egrep -i "\w*[äöõüšž]+\w*" | head -n 1000 > words.txt
cp words.txt tmp_all

# Make capitalized list
# Ugh... osx's matching is case insensitive so there's no way of knowing which will match first
# We'll have to make do with only the lowercase words for now
#cat words.txt | awk ' { $0=toupper(substr($0,1,1))substr($0,2); print } ' > tmp_capitalized
#cat tmp_capitalized >> tmp_all

# Filter uniques
cat tmp_all | sort -r | uniq > tmp_all_unique
rm tmp_all

# Make mapping
cat tmp_all_unique | sed -E "s/ü/\\[/g" | sed -E "s/õ/\]/g" | sed -E "s/ö/;/g" | sed -E "s/ä/'/g" | sed -e "s/š/sh/" | sed -e "s/ž/zh/" > tmp_all_unique_en
paste -d "," tmp_all_unique tmp_all_unique_en > final.csv

rm tmp_all_unique tmp_all_unique_en
