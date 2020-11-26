#!/bin/bash
function getUrl()
{

    [ ! -z "$2" ] &&
    {
        commit=$(cat "$2" | ./lastcommit.bash - )
        commit_count=$(cat "$2" | ./commits.bash - )

        echo "https://github.com/$1/commits?after=$commit+$((commit_count - 10))"
    } || {
        echo "https://github.com/$1/commits?after=$(./lastcommit.bash $1)+$(($(./commits.bash $1) - 10))"
    }
}

commit_count=$3
echo "https://github.com/$1/commits?after=$2+$((commit_count - 10))"

#getUrl $1 $2
