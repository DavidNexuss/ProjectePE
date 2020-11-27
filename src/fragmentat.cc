#include <iostream>
#include <cmath>
using namespace std;
/*
 * Utilitat per obtenir la raó entre el nombre de stars de un repositori i les dels seus forks.
 * El programa llegeix les dades del canal estàndard.
 * Primer el nombre de stars del repositori i despres les tuples de (fork,stars)
 * El programa espera que com a input hi hagi com a minim el nombre de stars del repositori i almenys
 * una tupla que representi un fork
 */
int main()
{
    int target;
    cin >> target;

    string nom;
    int stars;

    int total_stars = 0;
    int total = 0;
    while(cin >> nom >> stars)
    {
        total_stars += stars;
        total++;
    }
    cout << (float(total_stars)/float(target)) << endl;
}
