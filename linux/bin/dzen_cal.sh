#!/bin/sh
SERVICE='dzen2'
if ps ax | grep -v grep | grep $SERVICE > /dev/null
 then
killall dzen2
 else
TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`
(echo '^bg(#111111)^fg(#3488DE)'`date +'%A %d %B %Y %n'`; echo
\
# current month, hilight header and today
cal \
    | sed -re 's/^/   /' | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#3488DE)^bg(#111111)\1/;s/(^|[ ])($TODAY)($|[ ])/\1^bg(#3488DE)^fg(#111111)\2^fg(#6c6c6c)^bg(#111111)\3/"

# next month, hilight header
[ $MONTH -eq 12 ] && YEAR=`expr $YEAR + 1`
cal `expr \( $MONTH + 1 \) % 12` $YEAR \
    | sed -re 's/^/   /' | sed -e 's/^\(.*[A-Za-z][A-Za-z]*.*\)$/^fg(#3488DE)^bg(#111111)\1/'
) \
    | dzen2 -p -fg '#6c6c6c' -bg '#111111' -fn '-*-fixed-*-*-*-*-12-*-*-*-*-*-*-*' -x 1111 -y 730 -w 160 -l 18 -e 'onstart=uncollapse;key_Escape=ungrabkeys,exit'
fi
