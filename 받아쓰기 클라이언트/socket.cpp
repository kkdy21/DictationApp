#include "socket.h"
#include <iostream>

Socket::Socket()
{
    sock = socket(PF_INET, SOCK_STREAM, 0);

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr("192.168.1.143");
    //addr.sin_addr.s_addr = inet_addr("10.10.20.36");
    //    addr.sin_addr.s_addr = inet_addr("192.168.0.54");

    addr.sin_port = htons(8080);

    if (connect(sock, (struct sockaddr *)&addr, sizeof(addr)) == -1)
    {
        std::cout << "connect" << std::endl;
    }
}
