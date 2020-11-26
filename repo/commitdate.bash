#!/bin/bash
curl -Ls "$1" | grep 'relative-time' | sed 's/<[^>]*>//g' | head -n +1 | xargs
