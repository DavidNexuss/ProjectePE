#!/bin/bash
# Script que obte la data de un commit
# Input [URL]
# l'Url ha de ser la url de la pàgina d'historial de commits a la que el commit pertany

curl -Ls "$1" | grep 'relative-time' | head -n +1 | sed 's/.*datetime=//' | awk '{print $1}' | sed -e 's/^"//' -e 's/"$//' | sed "s/T.*//"
#| sed 's/<[^>]*>//g' | head -n +1 | xargs
