#!/bin/bash

# Find words with accented characters in them and cap the number
cut -d ' ' -f1 words/et-full-frequency.txt | egrep -i "\w*[äöõüšž]+\w*" | head -n 50000 > words.txt
cp words.txt tmp_all

# Filter uniques
cat tmp_all | sort -r | uniq > tmp_all_unique
rm tmp_all

# create US layout version of words
cat tmp_all_unique | sed -E "s/ü/\\[/g" | sed -E "s/õ/\]/g" | sed -E "s/ö/;/g" | sed -E "s/ä/'/g" | sed -e "s/š/sh/" | sed -e "s/ž/zh/" > tmp_all_unique_en

# Add :: prefix
sed -i -e 's/^/::/' tmp_all_unique
sed -i -e 's/^/::/' tmp_all_unique_en

# Make mapping
paste -d "" tmp_all_unique_en tmp_all_unique | iconv -f "utf8" -t "Windows-1252" > eesti_accent_autoexpand.ahk

# Remove ;'[] from ending characters, otherwise conversion will happen mid-word with some words
sed -i -e '1s;^;#Hotstring EndChars -(){}:"/\,.?!`n `t\n\n;' eesti_accent_autoexpand.ahk

rm tmp_all_unique tmp_all_unique_en
