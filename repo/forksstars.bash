#!/bin/bash
f=$(mktemp)
curl -Ls "https://api.github.com/repos/$1/forks?sort=stargazers&per_page=100" > $f
for i in $(seq $(cat "$f" | jq length)); do
    name=$(cat "$f" | jq ".[$i].name")
    echo "$(echo "$name" | tr -d "\"") $(cat "$f" | jq ".[$i].stargazers_count")"
done
rm $f
