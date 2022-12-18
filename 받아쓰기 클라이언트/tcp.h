#ifndef TCP_H
#define TCP_H

#include <QObject>
#include <QQuickView>
#include <QTcpSocket>
#include <QMediaPlayer>
#include "socket.h"
#include <thread>

using namespace std;

class TCP : public QObject
{
    Q_OBJECT

public:
    TCP();
    Socket *socket;
    QMediaPlayer *player;
    QStringList questionList;
    QStringList correct;



public slots:
    void _Login(QString ID, QString PW);
    void _Account(QString ID, QString PW);
    void _write(QString msg);
    QString _read();
    void _SendImage();
    void _PlaySound(QString fileName);
    void _RecvQuestionList(QString level);
    QString _returncorrect(int index);
    QString _GetQuestionList(int count);
signals:
    void loginStatus(QString msg);
    void accountStatus(QString msg);
    void StageStatus();

};

#endif // TCP_H
