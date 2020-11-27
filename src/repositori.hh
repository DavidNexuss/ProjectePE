#include <list>
#include <shared_ptr>

class Repositori
{
    string nom;
    int stars;
    std::list<std::shared_ptr<Repositori>> forks;

    public:

    Repositori(string _nom,int _stars);
    ~Repositori();

    bool es_fragmentat();
    bool afegir_fork(std::shared_ptr<Repositori> fork);
};
