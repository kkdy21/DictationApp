#include "ConnectEvent.h"

ConnectEvent::ConnectEvent()
{
    cout << "ConnectEvent" << endl;
    setTestList();//생성자에서 호출해서 객체가 만들어 지자마자 데이터를 vector에 담는다.
    qmlRegisterType<ConnectEvent>("ConnectEvent", 1, 0, "ConnectEvent");//class를 qml에서 사용하기 위해서 등록해주는 부분
}

void ConnectEvent::setWindow(QQuickWindow *Window)
{
    mMainView = Window;
}
void ConnectEvent::setTestList()
{
    TestStruct testStruct;
    for(int i = 0; i < 10; i++){

        testStruct.count=QString::number(i+1);
        testStruct.content = "정답나오는곳";
        if(i%2)
        testStruct.correct = "correct";
        else
        testStruct.correct = "notcorrect";
        mTestList.push_back(testStruct);
    }

}

int ConnectEvent::getListSize()
{
    return mTestList.size();
}

QString ConnectEvent::getListCount(int index)
{
    return mTestList[index].count;
}

QString ConnectEvent::getListContent(int index)
{
    return mTestList[index].content;
}

QString ConnectEvent::getListCorrect(int index)
{
    return mTestList[index].correct;
}
