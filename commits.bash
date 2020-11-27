#!/bin/bash
function parse()
{
    grep '<strong>' | sed '3q;d' | sed 's/<[^>]*>//g' | tr -d ',' | xargs
}
[ "$1" != "-" ] &&
{
    curl -Ls "https://github.com/$1" | parse
} || parse
