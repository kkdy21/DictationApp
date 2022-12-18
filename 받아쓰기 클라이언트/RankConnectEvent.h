#ifndef RANKCONNECTEVENT_H
#define RANKCONNECTEVENT_H

#include <QQuickItem>
#include <QQuickView>
#include <QObject>
#include <iostream>
using namespace std;

struct RankStruct
{
    QString Rank = "";
    QString ID = "";
    QString Infomation = "";
};

class RankConnectEvent: public QObject
{
public:
    Q_OBJECT
public:
    RankConnectEvent();
    void setWindow(QQuickWindow* Window);
    Q_INVOKABLE void setRankList(QString data);
    Q_INVOKABLE int getRankListSize();
    Q_INVOKABLE QString getListRank(int index);
    Q_INVOKABLE QString getListID(int index);
    Q_INVOKABLE QString getListInfomation(int index);

private:
    QQuickWindow* mMainView;
    vector<RankStruct> mRankList;
};

#endif // RANKCONNECTEVENT_H
