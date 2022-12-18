#ifndef __Server__
#define __Server__

#include "tcp.hpp"
#include "usercontrol.hpp"
#include <string>

class Server : public TcpServer {
private:
  string serv_fPath = "/home/daniel/바탕화면/badassugi_222/badassugi/photo/";

public:
  UserControl u;
  int port = 8080;
  void start_thread();
  void *_thread(void *arg);
  void upload(int sock, string route, string id);
  void send_image(int C_sock, string route, string id);
  string scoring(string msg, string question, int difficulty, string id);

  vector<string> split(string s, string divid);
};

#endif