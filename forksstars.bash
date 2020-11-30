#!/bin/bash
curl -u $(tail -n 1 credentials.conf) -Ls "https://api.github.com/repos/$1/forks?sort=stargazers&per_page=100" | jq '.[] | "\(.name) \(.stargazers_count)"' | tr -d '"'
