#!/bin/sh
# load display configuration
autorandr --change || true
emacs &
sleep 4
ws1=1:1.code
ws2=2:2.web
ws3=3:3.life
ws4=4:4.dict
ws5=5:5.media
ws6=13:13.projector
ws7=7:7.CG
ws8=8:8.flashcards
ws9=9:9.games
ws10=10:10.help
ws11=11:11.lib
ws12=12:12.email
ws13=6:6.IM

for i in {1..13}
do
   workspace="ws${i}"
   echo "Restore: ${!workspace}"
   i3-resurrect restore -w ${!workspace}
   sleep 1
done
