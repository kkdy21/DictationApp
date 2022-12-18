#include "usercontrol.hpp"

string UserControl::account_user(vector<string> v) {
  string temp = "0";
  sprintf(query, "insert into User values('%s', '%s')", v[1].c_str(),
          v[2].c_str());
  int check = mysql_query(connection, query);
  sql_result = mysql_store_result(connection);
  sprintf(query, "insert into Rank values('%s', 0)", v[1].c_str());
  mysql_query(connection, query);
  sql_result = mysql_store_result(connection);
  if (check == 0)
    temp = "1";
  return temp;
}

string UserControl::login_user(vector<string> v) {
  string temp = "0";
  sprintf(query, "select count(*) from User where id = '%s' and pwd = '%s'",
          v[1].c_str(), v[2].c_str());
  bool check = mysql_query(connection, query);
  sql_result = mysql_store_result(connection);
  sql_row = mysql_fetch_row(sql_result);
  if (strcmp(sql_row[0], "1") == 0)
    temp = "1";
  return temp;
}

string UserControl::id_check_user(vector<string> v) {
  string temp = "0";
  sprintf(query, "select count(*) from User where id = '%s'", v[1].c_str());
  mysql_query(connection, query);
  sql_result = mysql_store_result(connection);
  sql_row = mysql_fetch_row(sql_result);
  temp = sql_row[0];
  return temp;
}

string UserControl::start_game(vector<string> v, int C_sock) {
  string msg = "";

  sprintf(query,
          "select Name from Question where Difficulty = '%s' order by rand() "
          "limit 6",
          v[1].c_str());
  mysql_query(connection, query);
  sql_result = mysql_store_result(connection);
  //   sql_row = mysql_fetch_row(sql_result);

  while ((sql_row = mysql_fetch_row(sql_result)) != NULL) {
    msg = msg + sql_row[0] + "/";
    cout << "msg : " << msg << endl;
  }

  cout << "send msg : " << msg << endl;
  write(C_sock, msg.c_str(), strlen(msg.c_str()));

  return msg;
}
string UserControl::select_rank(int C_sock) {
  string msg = "";

  sprintf(query, "SELECT ID FROM `Rank` ORDER BY Score DESC limit 10");
  mysql_query(connection, query);
  sql_result = mysql_store_result(connection);

  while ((sql_row = mysql_fetch_row(sql_result)) != NULL) {
    msg = msg + sql_row[0] + "/";
  }

  cout << "rank : " << msg << endl;
  write(C_sock, msg.c_str(), strlen(msg.c_str()));

  return msg;
}

string UserControl::update_rank(string id, int score) {
  sprintf(query, "UPDATE Rank set Score = Score + %d where ID = '%s'", score,
          id.c_str());
  mysql_query(connection, query);

  return "";
}

void UserControl::exit(string id) {
  sprintf(query, "update user set sock = null where id = '%s';", id.c_str());
  mysql_query(connection, query);
}