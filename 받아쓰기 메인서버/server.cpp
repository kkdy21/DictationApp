#include "server.hpp"

// 쓰레드 생성함수
void Server::start_thread() {
  std::thread t1([&]() { _thread((void *)&clnt_sock); });
  t1.detach();
}

// 쓰레드 구현
void *Server::_thread(void *arg) {
  cout << "Thread" << endl;
  int C_sock = *((int *)arg);
  char msg[1024];
  int sig;
  string id = "1234";
  string save_port = "";
  vector<string> v;
  string send;
  string question = "";
  int difficulty = 0;

  while (true) {
    // 쓰레드 기능 구현!!
    memset(msg, 0, sizeof(msg));
    sig = read(C_sock, msg, sizeof(msg));
    {
      cout << msg << endl;

      v = split(msg, "/");
      for (string i : v) {
        cout << i << endl;
      }

      if (strcmp(msg, "exit/") == 0 || strcmp(msg, "EXIT/") == 0 || sig == -1) {
        cout << "종료요청" << endl;
        strcpy(msg, "exit");
        cout << "msg : " << msg << endl;
        u.exit(id);
        // write(C_sock, msg, strlen(msg));
        break;
      } else if (strcmp(msg, "logout/") == 0) {
        cout << "로그아웃" << endl;
        strcpy(msg, "logout");
        write(C_sock, msg, strlen(msg));
      }

      // 회원가입
      else if (strcmp(v[0].c_str(), "account") == 0) {
        cout << "회원가입" << endl;
        send = u.account_user(v);
        write(C_sock, send.c_str(), strlen(send.c_str()));
      }

      // 로그인
      else if (strcmp(v[0].c_str(), "login") == 0) {
        int check = 0;
        cout << "로그인" << endl;
        send = u.login_user(v);
        write(C_sock, send.c_str(), strlen(send.c_str()));
        id = v[1].c_str();
        cout << id << endl;
      }

      // 아이디 중복체크
      else if (strcmp(v[0].c_str(), "idcheck") == 0) {
        cout << "아이디 중복체크" << endl;
        send = u.id_check_user(v);
        write(C_sock, send.c_str(), strlen(send.c_str()));
      }

      else if (strcmp(v[0].c_str(), "start") == 0) {
        cout << "게임 시작" << endl;
        question = u.start_game(v, C_sock);
        difficulty = atoi(v[1].c_str());
      }

      else if (strcmp(v[0].c_str(), "image") == 0) {
        char msg[1024] = "";
        string send_msg = "";

        TcpClient tcpClient;
        int P_sock = 0;

        string route = serv_fPath;
        // string route = "/home/iot2115/serv/photo2/";

        cout << "이미지 수신" << endl;
        upload(C_sock, route, id);
        cout << "upload end" << endl;
        P_sock = tcpClient.connect_serv(P_sock);
        cout << "python server connected" << endl;
        send_image(P_sock, route, id);
        cout << "image send end" << endl;
        read(P_sock, msg, sizeof(msg));
        cout << "recv msg : " << msg << endl;
        tcpClient.close_sock(P_sock);

        send_msg = scoring(msg, question, difficulty, id);
        cout << "send_msg" << send_msg << endl;
        write(C_sock, send_msg.c_str(), strlen(send_msg.c_str()));

        


      }

      else if (strcmp(v[0].c_str(), "ranking") == 0) {
        cout << "랭킹 요청" << endl;
        u.select_rank(C_sock);
      }

      else {
      }
    }
  }

  m.lock();
  for (int i = 0; i < clnt_cnt; i++) {
    if (C_sock == clnt_socks[i]) {
      while (i++ < clnt_cnt - 1) {
        clnt_socks[i] = clnt_socks[i + 1];
      }
      break;
    }
  }

  clnt_cnt--;
  m.unlock();

  cout << C_sock << " Thread end" << endl;

  close(C_sock);
  return NULL;
}

void Server::send_image(int C_sock, string route,
                        string id) // 이미지 전송 메소드
{
  string msg = id;
  write(C_sock, msg.c_str(), strlen(msg.c_str()));
  cout << "msg : " << msg << id << endl;
  int num = 0;
  while (num < 20) {
    route = serv_fPath + id + "_" + to_string(num) + ".png\0";
    // route = "/home/iot2115/serv/photo2/" + id + "_" + to_string(num) +
    // ".png\0";
    char Recv_OK[20];

    FILE *file = fopen(route.c_str(), "rb");
    if (file == NULL)
      cout << "file open error " << endl;

    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    rewind(file);

    string file_size = to_string(size) + "\0";
    write(C_sock, file_size.c_str(), strlen(file_size.c_str()));

    cout << "size sended" << endl;

    read(C_sock, Recv_OK, sizeof(Recv_OK));

    cout << "read" << endl;

    char *data = nullptr;
    data = (char *)malloc(sizeof(char) * size);

    fread(data, 1, size, file);
    write(C_sock, data, size);
    memset(data, 0, sizeof(data));

    cout << "file sended" << endl;

    free(data);
    fclose(file);

    read(C_sock, Recv_OK, sizeof(Recv_OK));

    cout << "파일 전송 완료" << endl;
    num++;
  }
}

void Server::upload(int C_sock, string route, string id) // 업로드 메소드
{
  int num = 0;
  while (1) {
    route = serv_fPath + id + "_" + to_string(num) + ".png\0";
    // route = "/home/iot2115/serv/photo2/" + id + "_" + to_string(num) +
    // ".png\0";
    long filesize = 0;
    char fsize[200] = {'\0'};
    cout << "업로드 대기" << endl;
    read(C_sock, fsize, sizeof(fsize));

    if (strcmp(fsize, "END") == 0) {
      cout << "업로드 끝" << endl;
      break;
    }

    filesize = atoi(fsize);
    write(C_sock, "OK\0", strlen("OK\0"));
    FILE *file = fopen(route.c_str(), "wb");

    long total_size = 0;
    int bufsize = 256;
    int byte = 0;
    unsigned char file_data[bufsize] = {'\0'};
    while (filesize > total_size) {
      if ((byte = read(C_sock, file_data, sizeof(file_data))) == -1)
        return;
      fwrite(file_data, sizeof(char), byte, file);
      total_size += byte;
      cout << file_data << endl;
    }
    write(C_sock, "OK\0", strlen("OK\0"));

    fclose(file);
    num++;
  }
}

string Server::scoring(string msg, string question, int difficulty, string id) {
  vector<string> v_msg;
  vector<string> v_ques;
  v_msg = split(msg, "/");
  v_ques = split(question, "/");
  int score = 0;
  string send_msg = "";
  string Mysubmit="";

  for (int i = 1; i < 6; i++) {

    cout << v_msg[i] << "," << v_ques[i - 1] << endl;

    if (v_msg[i] == v_ques[i - 1]) {
      score += difficulty;
      send_msg = send_msg + "OK/";
      Mysubmit = Mysubmit + v_msg[i] + "/";
      cout << "OK증가" << endl;
    } else {
      send_msg = send_msg + "NO/";
      Mysubmit = Mysubmit + v_msg[i] + "/";
      cout << "NO증가" << endl;
    }
  }
  send_msg = send_msg + Mysubmit;

  u.update_rank(id, score);

  return send_msg;
}

vector<string> Server::split(string s, string divid) {
  vector<string> v;
  char *c = strtok((char *)s.c_str(), divid.c_str());
  while (c) {
    v.push_back(c);
    c = strtok(NULL, divid.c_str());
  }
  return v;
}
