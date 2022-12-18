#ifndef CONNECTEVENT_H
#define CONNECTEVENT_H

#include <QQuickItem>
#include <QQuickView>
#include <QObject>
#include <iostream>
using namespace std;

struct TestStruct
{
    QString count ="";
    QString content="";
    QString correct="";
};

class ConnectEvent : public QObject
{
public:
    Q_OBJECT

public:
    ConnectEvent();
    void setWindow(QQuickWindow* Window);
    void setTestList();

    Q_INVOKABLE int getListSize();
    Q_INVOKABLE QString getListCount(int index);
    Q_INVOKABLE QString getListContent(int index);
    Q_INVOKABLE QString getListCorrect(int index);

private:
    QQuickWindow* mMainView;
    vector<TestStruct> mTestList;
};

#endif // CONNECTEVENT_H
