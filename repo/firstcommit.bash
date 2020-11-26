#!/bin/bash
function getUrl()
{

    [ ! -z "$2" ] &&
    {
        commit=$(cat "$2" | ./lastcommit.bash - )
        commit_count=$(cat "$2" | ./commits.bash - )

        echo "https://github.com/$1/commits/master?after=$commit+$((commit_count - 10))"
    } || {
        echo "https://github.com/$1/commits/master?after=$(./lastcommit.bash $1)+$(($(./commits.bash $1) - 10))"
    }
}

getUrl $1 $2
