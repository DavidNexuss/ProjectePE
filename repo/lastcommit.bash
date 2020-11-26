#!/bin/bash
function parse()
{
    grep 'data-pjax' | grep "f6 link" | \
    grep -io '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
    sed -e 's/^<a href=["'"'"']//i' -e 's/["'"'"']$//i' | \
    sed 's/.*commit\///'
}
[ "$1" != "-" ] && { 
    curl -Ls "https://github.com/$1" | parse 
} || parse

