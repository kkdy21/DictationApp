#include "tcp.hpp"
#include <cstring>
#include <cstdlib>
#include <unistd.h>

////////// 기본 서버 클래스 //////////

void TcpServer::init_serv(int MaxClnt)
{
    clnt_cnt = 0;
    clnt_socks = new int[MaxClnt];

    serv_sock = socket(PF_INET, SOCK_STREAM, 0);
    memset(&serv_adr, 0, sizeof(serv_adr));
    serv_adr.sin_family = AF_INET;
    serv_adr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_adr.sin_port = htons(PORT);

    //바인드에러 안나게
    int opt = 1;
    setsockopt(serv_sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    if (bind(serv_sock, (struct sockaddr *)&serv_adr, sizeof(serv_adr)) == -1)
    {
        std::cout << "bind() error" << std::endl;
        exit(1);
    }

    if (listen(serv_sock, 5) == -1)
    {
        std::cout << "listen() error" << std::endl;
        exit(1);
    }
}

void TcpServer::accept_socks()
{
    clnt_adr_sz = sizeof(clnt_adr);
    cout << "연결 대기중 " << endl;
    clnt_sock = accept(serv_sock, (struct sockaddr *)&clnt_adr, &clnt_adr_sz);
    m.lock();
    clnt_socks[clnt_cnt++] = clnt_sock;
    m.unlock();
    printf("Connected client IP : %s \n", inet_ntoa(clnt_adr.sin_addr));
}

void TcpServer::close_serv()
{
    close(serv_sock);
}

////////// 기본 서버 클래스 끝 //////////

////////// 기본 클라이언트 클래스 //////////

int TcpClient::connect_serv(int sock)
{
    sock = socket(PF_INET, SOCK_STREAM, 0);

    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr("10.10.20.38");
    serv_addr.sin_port = htons(8888);

    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) == -1)
    {
        std::cout << "connect() error" << std::endl;
        exit(1);
    }

    else
    {
        std::cout << "connected" << std::endl;
        return sock;
    }
}

void TcpClient::close_sock(int sock)
{
    close(sock);
}

////////// 기본 클라이언트 클래스 끝 //////////

bool DBconn::DB_connect()
{
    m.lock();
    connection = mysql_real_connect(&conn, DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT, (char *)NULL, 0);

    if (connection == NULL)
    {
        fprintf(stderr, "Mysql connection error : %s", mysql_error(&conn));
        return false;
    }
    return true;
}

void DBconn::DB_disconnect()
{
    mysql_free_result(sql_result);
    // connection = NULL;
    mysql_close(connection);
    m.unlock();
}

DBconn::DBconn()
{
    connection = NULL;
    mysql_init(&conn);
}
DBconn::~DBconn()
{
    if (&conn != NULL)
        mysql_close(&conn);
}