#!/bin/bash
f=$(mktemp)
./getforks.bash $1 > $f
cat $f | xargs -n 1 -P 3 ./stars.bash 
rm $f
