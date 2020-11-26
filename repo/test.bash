#!/bin/bash
function test_meta()
{
    f=$(mktemp)
    curl -Ls "https://github.com/$1" > "$f"
    echo ""
    (
    echo -e "Cantitat de commits: | \e[32m $(cat "$f" | ./commits.bash -) \e[39m"
    echo -e "Ultim commit: | \e[32m $(cat "$f" | ./lastcommit.bash -) \e[39m"
    first_commit=$(./firstcommit.bash "$1" "$f")
    echo -e "Primer commit: | \e[32m $first_commit \e[39m"
    echo -e "Data inici: | \e[32m $(./commitdate.bash "$first_commit")\e[39m"
    ) | column -t -s "|"
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
