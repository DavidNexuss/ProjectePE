#!/bin/bash

# Script que obté les metadades en format de text pla
# L'Script assumeix que el repositori existeix i es accesible
# Input [repo]
# Output stars temps valor

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
echo "$stars" > $f2
./forksstars.bash $1 >> $f2
valor=$(cat "$f2" | ./fragmentat)
rm $f2

echo "$1 $stars $temps $valor"
rm $f
