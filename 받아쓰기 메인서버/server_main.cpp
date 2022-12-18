#include "server.hpp"

int main()
{
    Server server;
    server.init_serv(8);

    while (true)
    {
        server.accept_socks();
        server.start_thread();
    }
}