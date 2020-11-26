#!/bin/bash
function parse()
{
    grep 'users starred' | sed 's/.*="//' | awk '{print $1}'
}
[ "$1" != "-" ] &&
{
    curl -Ls "https://github.com/$1" | parse
} || parse
