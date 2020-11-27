#!/bin/bash
curl -Ls "https://api.github.com/repos/$1/forks?sort=stargazers&per_page=100" | jq '.[] | "\(.name) \(.stargazers_count)"' | tr -d '"'
