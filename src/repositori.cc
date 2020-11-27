#include "repositori.hh"

Repositori(string _nom,int _stars) : nom(_nom), stars(_stars) { }

bool Repositori::afegir_fork(shared_ptr<Repositori> fork)
{
    forks.push_back(fork);
}
