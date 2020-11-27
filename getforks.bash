#!/bin/sh
curl -Ls "https://github.com/$1/network/members" | grep 'a href="/' | sed 's/^.*href="\///' | sed 's/".*//' | grep -o '.*/.*' | grep -v 'features' | tail -n +3
