#!/bin/bash
echo "" > sqlite_cmds
echo "create table TMP12345 (ZPHRASE VARCHAR(60), ZSHORTCUT VARCHAR(60));" >> sqlite_cmds
echo ".mode csv" >> sqlite_cmds
echo ".separator ','" >> sqlite_cmds
echo ".import '$PWD/final.csv' TMP12345" >> sqlite_cmds;
echo "INSERT INTO ZUSERDICTIONARYENTRY(ZPHRASE, ZSHORTCUT) SELECT * FROM TMP12345;" >> sqlite_cmds
echo "drop table TMP12345;" >> sqlite_cmds

cp -n $1 bak/

sqlite3 $1 < sqlite_cmds

rm sqlite_cmds
killall AppleSpell
