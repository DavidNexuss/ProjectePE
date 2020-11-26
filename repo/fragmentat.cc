#include <iostream>
#include <cmath>

using namespace std;

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
    cout << target << " " << total_stars << " " << (float(total_stars)/float(target)) << endl;
}
