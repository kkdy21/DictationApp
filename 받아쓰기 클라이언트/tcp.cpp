#include "tcp.h"


TCP::TCP()
{
    socket = new Socket();


}


void TCP::_Login(QString ID, QString PW)
{
    QString msg = "login/"+ID+"/"+PW;

    socket->_write(msg);

    msg = socket->_read();

    emit loginStatus(msg);
}

void TCP::_Account(QString ID, QString PW)
{
    QString msg = "account/"+ID+"/"+PW;

    socket->_write(msg);

    msg = socket->_read();

    emit accountStatus(msg);
}

void TCP::_write(QString msg){
    socket->_write(msg);
}



QString TCP::_read(){
    return socket->_read();
}


void TCP::_SendImage(){

    char Recv_OK[20];
    QString msg = "image";
    socket->_write(msg);

    qDebug() << "--0";
    for(int i=1; i<=5;i++){
        for(int j=1;j<=4;j++){
            string route = "/storage/emulated/0/QT/" + to_string(i)+"_"+to_string(j) + ".png";


            qDebug() << "-------------------------------1";

            FILE *file = fopen(route.c_str(), "rb");
            if (file == NULL)
                cout << "file open error " << endl;

            fseek(file, 0, SEEK_END);
            long size = ftell(file);
            rewind(file);

            qDebug() << "-------------------------------2";


            string file_size = to_string(size) + "\0";
            write(socket->sock, file_size.c_str(), strlen(file_size.c_str()));

            qDebug() << "-------------------------------3";

            read(socket->sock, Recv_OK, sizeof(Recv_OK));

            qDebug() << "-------------------------------4";

            char *data = nullptr;
            data = (char *)malloc(sizeof(char) * size);

            fread(data, 1, size, file);
            write(socket->sock, data, size);
            memset(data, 0, sizeof(data));
            free(data);
            fclose(file);

            qDebug() << "-------------------------------5";

            read(socket->sock, Recv_OK, sizeof(Recv_OK));

            qDebug()<< "파일 전송 완료";



        }
    }
    msg = "END\0";
    write(socket->sock,msg.toStdString().c_str(),strlen(msg.toStdString().c_str()));
    qDebug()<< "모든 파일 전송 완료";

    QString submitresult = socket->_read();
    qDebug()<<submitresult;

    correct=submitresult.split("/");

}

QString TCP::_returncorrect(int index)
{
    return correct[index];
}

void TCP::_PlaySound(QString fileName)
{
    player = new QMediaPlayer();
    player->setMedia(QUrl("qrc:/sound/"+fileName+".mp3"));
    player->play();
}

void TCP::_RecvQuestionList(QString level){
    socket->_write(level);
    QString msg = socket->_read();
    questionList = msg.split("/");
}

QString TCP::_GetQuestionList(int count){
    return questionList[count];
}
