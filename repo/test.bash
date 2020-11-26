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

        echo -e "Stars: | \e[32m $(cat "$f" | ./stars.bash -) \e[39m"
        echo -e "Forks: | \e[32m $(cat "$f" | ./forks.bash -) \e[39m"

    ) | column -t -s "|"

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
    echo -e "\e[96m 1)\e[39m Obtindre metadades de un projecte en concret       [nomusuari/nomrepo]"
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
    *) echo "Operació ${input[0]} no reconeguda" 
       exit 1;;
esac
[ "$1" != "-s" ] && 
{
    echo ""
    print_helper
}
done
