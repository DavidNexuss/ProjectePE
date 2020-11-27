#include <iostream>
using namespace std;

/*
 * Utilitat que extrau urls de repositoris de github d'un text rebut per stdin
 * Llegeix línia a línia, filtrant amb les següents operacions:
 *
 * 1) Només les que tenen github.com/
 * 2) Esborra tot el text fins el caràcter " i només imprimeix en cas que la url tingui dues '/', el format de les urls de repos
 *
 * No garanteix que la url sigui un repo només que aquesta compleix el format
 */

bool valid(char c)
{
    return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c == '/' || c == '.');
}
int count_bars(const string& s)
{
    int c = 0;
    for(int i = 0; i < s.length(); i++)
    {
        c += s[i] == '/';
        if (!valid(s[i])) return -1;
    }
    return c;
}
int main()
{

    string l;
    string pattern  = "github.com/";

    while (getline(cin,l))
    {
        size_t pos = l.find(pattern);
        if (pos == string::npos) continue;

        string str1 = l.substr(pos + pattern.size());
        size_t end = str1.find("\"");
        if (end != string::npos)
            str1 = str1.substr(0,end);
        if(count_bars(str1) == 1) cout << str1 << endl;
    }
}
