#!/bin/bash
function parse()
{
    grep 'commit/' | head -n +1 | sed 's/^.*commit\///' | awk '{print $1}' | tr -d "\"" | \
        sed 's/>.*//'

    #grep 'data-pjax' | grep "f6 link" | \
    #grep -io '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
    #sed -e 's/^<a href=["'"'"']//i' -e 's/["'"'"']$//i' | \
    #sed 's/.*commit\///'
}
[ "$1" != "-" ] && { 
    curl -Ls "https://github.com/$1" | parse 
} || parse

