#!/bin/bash
function test_meta()
{
    f=$(mktemp)
    curl -Ls "https://github.com/$1" > "$f"
    (

        commit_count=$(cat "$f" | ./commits.bash -)
        last_commit=$(cat "$f" | ./lastcommit.bash -)
        first_commit=$(./firstcommit.bash "$1" "$last_commit" "$commit_count")


        data_inici=$(./commitdate.bash "$first_commit")
        data_fi=$(./commitdate.bash "https://github.com/$1/commits")
        temps=$(( $(date -d "$data_fi" +%s) - $(date -d "$data_inici" +%s) ))
        temps=$((temps / 86400))


        echo -e "Cantitat de commits: | \e[32m $commit_count \e[39m"
        echo -e "Ultim commit: | \e[32m $last_commit \e[39m"
        echo -e "Primer commit: | \e[32m $first_commit \e[39m"

        echo -e "Data inici: | \e[32m $data_inici\e[39m"
        echo -e "Data Fi: | \e[32m $data_fi\e[39m"
        echo -e "Temps: | \e[32m $temps \e[39m"

        stars=$(cat "$f" | ./stars.bash -)
        echo -e "Stars: | \e[32m $stars \e[39m"
        echo -e "Forks: | \e[32m $(cat "$f" | ./forks.bash -) \e[39m"

        f2=$(mktemp)
        echo "$stars" > a
        ./forksstars.bash $1 >> a
        echo -ne "Es fragmentat?    "
        cat a | ./fragmentat
        rm $f2
    ) | column -t -s "|"

    rm $f
}
function meta()
{
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
}

function print_greet()
{
    echo "Suite de tests per obtenir metadades de projectes de Github"
    
    echo -e '\e[36m  ____ _ _   __  __      _        _____ _           _           ' 
    echo -e ' / ___(_) |_|  \/  | ___| |_ __ _|  ___(_)_ __   __| | ___ _ __ ' 
    echo -e '| |  _| | __| |\/| |/ _ \ __/ _` | |_  | | |_ \ / _` |/ _ \ |__|'
    echo -e '| |_| | | |_| |  | |  __/ || (_| |  _| | | | | | (_| |  __/ |   ' 
    echo -e ' \____|_|\__|_|  |_|\___|\__\__,_|_|   |_|_| |_|\__,_|\___|_|   ' 
    echo -e '\e[39m'
                                                                
}

function print_helper()
{
    echo "Escull operació a executar: "
    echo -e "\e[96m 1)\e[39m Obtindre metadades de un projecte en concret               "
    echo -e "\e[96m 2)\e[39m Obtindre llistat de forks de un projecte en concret        "
    echo -e "\e[96m 3)\e[39m Obtindre llistat de forks de un projecte en concret (ordenat per popularitat)       "
    echo -e "\e[96m 4)\e[39m Obtindre dades       "
}

[ "$1" != "-s" ] && 
{
    print_greet
    print_helper
}
while read -a input; do 
[ "$1" != "-s" ] && echo ""
case "${input[0]}" in
    1) test_meta ${input[1]} ;;
    2) ./getforks.bash ${input[1]} ;;
    3) ./forksstars.bash ${input[1]} ;;
    4) export -f meta
        while read line; do
            meta $line
        done;;
    *) echo "Operació ${input[0]} no reconeguda" 
       exit 1;;
esac
[ "$1" != "-s" ] && 
{
    echo ""
    print_helper
}
done
