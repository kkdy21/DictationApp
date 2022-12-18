#ifndef SOCKET_H
#define SOCKET_H

#include <arpa/inet.h>
#include <sys/socket.h>
#include <iostream>
#include <unistd.h>
#include <QString>

class Socket
{
public:
    Socket();
    sockaddr_in addr;
    int sock;

    QString _read()
    {
        char msg[1024] = "\0";

        read(sock, msg, sizeof(msg));

        std::cout <<"받은 메세지 :" << msg <<std::endl;

        return msg;
    }

    void _write(QString temp1)
    {
        std::string temp = temp1.toStdString();

        std::cout<< "보내는 메세지 :" << temp.c_str() <<std::endl;

        write(sock, temp.c_str(), strlen(temp.c_str()));
    }
};

#endif // SOCKET_H
