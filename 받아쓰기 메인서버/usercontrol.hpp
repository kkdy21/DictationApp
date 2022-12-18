#ifndef __User_Control__
#define __User_Control__
#include "tcp.hpp"

class UserControl : DBconn
{
public:
    // DB...
    string account_user(vector<string> v);
    string login_user(vector<string> v);
    string id_check_user(vector<string> v);
    string start_game(vector<string> v,int C_sock);
    string select_rank(int C_sock);
    string update_rank(string id, int score);
    void exit(string id);
    int view = 0;
    UserControl()
    {
        DB_connect();
    };
    ~UserControl()
    {
        DB_disconnect();
    };
};

#endif