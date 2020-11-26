#!/bin/bash
f=$(mktemp)
curl -Ls "https://github.com/$1" > "$f"

commit_count=$(cat "$f" | ./commits.bash -)
last_commit=$(cat "$f" | ./lastcommit.bash -)
first_commit=$(./firstcommit.bash "$1" "$last_commit" "$commit_count")


data_inici=$(./commitdate.bash "$first_commit")
data_fi=$(./commitdate.bash "https://github.com/$1/commits")
temps=$(( $(date -d "$data_fi" +%s) - $(date -d "$data_inici" +%s) ))
temps=$((temps / 86400))

stars=$(cat "$f" | ./stars.bash -)


f2=$(mktemp)
echo "$stars" > a
./forksstars.bash $1 >> a
valor=$(cat a | ./fragmentat)
rm $f2

echo "$stars $temps $valor"
rm $f
