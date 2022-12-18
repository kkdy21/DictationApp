#include "RankConnectEvent.h"

RankConnectEvent::RankConnectEvent()
{
    cout << "RankConnectEvent" << endl;
    //setRankList();//생성자에서 호출해서 객체가 만들어 지자마자 데이터를 vector에 담는다.
    qmlRegisterType<RankConnectEvent>("RankConnectEvent", 1, 0, "RankConnectEvent");//class를 qml에서 사용하기 위해서 등록해주는 부분
}

void RankConnectEvent::setRankList(QString data)
{   QStringList dataList = data.split("/");
    RankStruct testStruct;
    for(int i = 0; i < 10; i++){
        testStruct.Rank = QString::number(i+1);//int형 변수를 QString 형으로 형변환
        testStruct.ID = "ID : " + dataList[i];
        mRankList.push_back(testStruct);
    }
}

int RankConnectEvent::getRankListSize()//리스트의 크기를 가져오기 위함 함수
{
    return mRankList.size();
}

QString RankConnectEvent::getListRank(int index)//리스트 인덱스의 제목을 가져오기 위한 함수
{
    return mRankList[index].Rank;
}

QString RankConnectEvent::getListID(int index)//리스트 인덱스의 버튼 텍스트를 가져오기 위한 함수
{
    return mRankList[index].ID;
}

QString RankConnectEvent::getListInfomation(int index)//리스트 인덱스의 내부 정보를 가져오기 위한 함수
{
    return mRankList[index].Infomation;
}
