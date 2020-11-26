#!/bin/bash

function ctrl_c()
{
    echo "Finishing execution, killing everyone..." 1>&2
    pkill -P $$
    echo "Goodbye!" 1>&2
    exit 0
}

{ 
    [ -z $1 ] || [ -z $2 ] 
} && 
{
    echo "Parametres invalids, per favor llegeixte la documentació" 1>&2
    exit 1
}

trap ctrl_c INT
for d in $(seq $1 $2); do
    for i in $(seq -f "%02g" 12); do
        for j in $(seq -f "%02g" 30); do
            lynx -dump -listonly https://web.archive.org/web/"$d$i$j"001920/https://github.com/trending
        done
        wait
    done 
done | grep -o '<a .*href=.*>' | sed -e 's/<a/\n<a/g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | grep -o -P "https:\/\/github\.com\/(.+?)\/(.+?)\/" | grep -v "trending" | sort | uniq
