import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0
import RankConnectEvent 1.0
import TCP 1.0


Item {
    id: item1
    anchors.fill: parent

    property double _width: width / 270
    property double _height: height / 570

    Rectangle
    {
        id: image
        height: 150*_height
        width:item1.width
        z: 20
    }

    Image {
        x: (parent.width-this.width)/2
        anchors.top: parent.top
        anchors.topMargin: 10*_height
        width: 130*_width
        height: 130*_height
        source: "images/트로피.png"
        z: 32
        fillMode: Image.PreserveAspectFit
    }

    RankConnectEvent//클래스를 qml 타입으로 지정
    {
        id:event

    }

    property string temp: "";
    Component.onCompleted://view가 처음 실행될때 제일 처음으로 불려지는곳
    {
        event.setRankList(_tcp._read());
        for(var i = 0; i < event.getRankListSize(); i++){//리스트의 개수만큼 for문을 돌린다.
            temp = event.getListRank(i);
            if( temp == "1"){
                temp = "images/금.png";
            }else if(temp == "2"){
                temp = "images/은.png";
            }else if(temp == "3"){
                temp= "images/동.png";
            }else{
                temp = "images/별.png";
            }
            listView.model.append({"tempImage":temp,"list_text": event.getListRank(i),//모델에 리스트의 데이터값을 넣어준다.
                                      "list_button_text": event.getListID(i)})//listview에 선언한 임의의 모델 안에 데이터를 넣어준다.
        }
    }

    Component {//리스트 뷰의 틀을 만든다.
        id: contactDelegate

        Item {
            id:item2
            anchors.horizontalCenter: item1.top
            anchors.top: image.bottom
            width: parent.width
            height: 80*_height

            Rectangle
            {
                id:rankImageRectangle
                height: item2.height
                width: item2.width/5
                anchors.left: rankImage.right
                color: "transparent"
                Image{
                    width: 50*_height
                    height: 50*_height
                    x:(parent.width-this.width)/2
                    y:(parent.height-this.height)/2
                    source: tempImage
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle
            {
                id:rankTextRectangle
                height: item2.height
                width: item2.width/5
                anchors.left: rankImageRectangle.right
                color: "transparent"
                Text
                {
                    text:list_text + " 등"//모델에 매칭이될 변수 listview에 원하는 값을 넣기위해서 설정하는 값
                    x:(parent.width-this.width)/2
                    y:(parent.height-this.height)/2
                }
            }
            Rectangle
            {
                height: item2.height
                width: item2.width*3/5
                anchors.left: rankTextRectangle.right
                color: "transparent"
                Text
                {
                    text: list_button_text//모델에 매칭이될 변수 listview에 원하는 값을 넣기위해서 설정하는 값
                    x:(parent.width-this.width)/2
                    y:(parent.height-this.height)/2
                }
            }
            Rectangle//리스트의 구분선
            {
                id:line
                width:parent.width
                anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                height:5*_height
                color:"lightgray"
                radius: 20
            }
            MouseArea
            {
                id:listMouseArea
                anchors.fill: parent
                onClicked:
                {
                    listView.currentIndex = index;//여기에서 사용하는 index는 클릭했을때의 index를 리턴해준다
                }
            }
        }

    }

    Component{
        id: highlight
        Rectangle {
            width:item2.width
            height: 80*_height
            y: listView.currentItem.y
            color: "lightsteelblue"
            radius: 20
            Behavior on y{
                SpringAnimation{
                    spring:3
                    damping: 0.2
                }
            }
        }
    }

    Item{
        id: item3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: image.bottom
        anchors.bottom: button.top
        anchors.rightMargin:10
        anchors.leftMargin: 10
        anchors.bottomMargin: 5


        ListView {
            id:listView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            z:20

            model: ListModel{}//임으로 만들 모델을 넣어준다.
            delegate: {
                contactDelegate
            }//delegate란 리스트 한개의 틀(틀을 하나 만들어서 그것들을 여러개 붙여놓은것이 리스트 뷰이다.)

            highlight: highlight
            focus: true;
        }
    }
    Button{
        id:button
        anchors.bottom: item1.bottom
        width: item1.width
        height: 40*_width
        text: "확  인"
        MouseArea{
            anchors.fill:parent
            onClicked: {  stackView.pop()}
        }
    }
}






/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:17}D{i:16}
}
##^##*/
