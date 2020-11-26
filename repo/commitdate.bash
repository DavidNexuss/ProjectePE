#!/bin/bash
curl -Ls "$1" | grep 'relative-time' | head -n +1 | sed 's/.*datetime=//' | awk '{print $1}' | sed -e 's/^"//' -e 's/"$//' | sed "s/T.*//"
#| sed 's/<[^>]*>//g' | head -n +1 | xargs
