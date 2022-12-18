#ifndef __TCP__
#define __TCP__

#include <iostream>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>
#include <string>
#include <arpa/inet.h>
#include <vector>
#include <thread>
#include <mutex>
#include <cstring>
#include <cstdio>
#include "/usr/include/mysql/mysql.h"

using namespace std;

#define DB_HOST "127.0.0.1"
#define DB_USER "root"
#define DB_PASS "1234"
#define DB_NAME "test"
#define DB_PORT 3306

#define IP "127.0.0.1"
#define PORT 8080

class TcpServer
{
protected:
    int serv_sock;
    int clnt_sock;
    int *clnt_socks;
    int clnt_cnt;
    struct sockaddr_in serv_adr, clnt_adr;
    socklen_t clnt_adr_sz;

    mutex m;

public:
    void init_serv(int MaxClnt);
    void accept_socks();
    void close_serv();
};

class TcpClient
{
protected:
    //int sock;
    struct sockaddr_in serv_addr;

public:
    int connect_serv(int sock);
    void close_sock(int sock);
};

class DBconn
{
protected:
public:
    DBconn();
    ~DBconn();
    mutex m;
    MYSQL *connection;
    MYSQL conn;
    MYSQL_RES *sql_result;
    MYSQL_ROW sql_row;
    int query_stat;
    char query[255];

    bool DB_connect();    // sql conn
    void DB_disconnect(); // sql disconn
};

#endif
