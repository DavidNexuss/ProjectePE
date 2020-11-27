#include <iostream>
#include <sstream>
#include <fstream>
#include <list>
#include <unordered_map>
#include <memory>
#include <vector>

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
using namespace std;


class Repo;
class Database;
typedef Repo* Repo_ptr;

extern Database database;

struct RepoData
{
    int stars;
    time_t creation_date;
    time_t last_commit_date;

};

class Repo
{
    string nom;
    RepoData data;

    vector<int> fork_stars;
    int fork_count;
    bool is_fork;
    /*
    Repo_ptr father;

    list<Repo_ptr> forks;
    */

    public:

    Repo(string _nom) : nom(_nom) {  }
    Repo(string _nom,RepoData _data) : nom(_nom), data(_data) {  }

    void queryRepoData()
    {
        //Query repo data
    }
    bool isFragmented()
    {
        //Fragmented criteria
    }
};

class Database
{
    unordered_map<string,Repo_ptr> all_repos;

    public:
    void addRepo(const string& name,int deep = true)
    {
        auto pos = all_repos.find(name);
        if (pos == all_repos.end())
        {
            Repo_ptr ptr = new Repo(name);
            all_repos.insert({name,ptr});
            ptr->queryRepoData(deep);
        }
        
    }
    void read(istream& is)
    {
        string name;
        while(is >> name)
        {
            addRepo(name);
        }
    }
};

Database database;
int main()
{
    ifstream is("data");
    database.read(is);
}
