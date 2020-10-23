#!/bin/bash

function ctrl_c()
{
    echo "Finishing execution, killing everyone..."
    pkill -P $$
    echo "Goodbye!"
    exit 0
}

{ 
    [ -z $1 ] || [ -z $2 ] 
} && 
{
    echo "Parametres invalids, per favor llegeixte la documentació"
    exit 1
}

trap ctrl_c INT
for d in $(seq $1 $2); do
    for i in $(seq -f "%02g" 12); do
        for j in $(seq -f "%02g" 30); do
            {
            echo "Starting $d-$i-$j..." 1>&2
            curl -sL https://web.archive.org/web/"$d$i$j"001920/https://github.com/trending
            } & 
        done
        wait
    done 
done | grep 'muted-link d-inline-block mr-3'  | awk '{print $6}'
