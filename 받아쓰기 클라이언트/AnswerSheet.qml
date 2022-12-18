import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import ConnectEvent 1.0
import QtTest 1.0
import TCP 1.0
import "."
Item{



    ConnectEvent
    {
        id:connectEvent
    }

    id: item1

    width: parent.width
    height: parent.height

    property string pageName: "answerSheet"
    property double _width: item1.width / 270
    property double _height: item1.height / 570
    property int score:0


    AnimatedImage{
        id:thumbs
        anchors.centerIn: parent
        source: "images/thumbs_up.gif"
    }

    SequentialAnimation{
        id: thumbs_animation3

        ParallelAnimation{
            id: thumbs_animation
            NumberAnimation {targets: [thumbs]; properties: "scale"; from: 0.4; to:1.5;   duration: 1000}
            NumberAnimation {targets: [thumbs]; properties: "opacity"; from: 0; to:1;   duration: 1000}
            running: true

        }

        PauseAnimation {
            duration: 500
        }

        ParallelAnimation{
            id: thumbs_animation2
            NumberAnimation {  target:  [thumbs]; properties: "x"; duration: 500; from: thumbs.x; to:thumbs_image.x; }
            NumberAnimation {  target:  [thumbs]; properties: "y"; duration: 500; from: thumbs.y; to:thumbs_image.y; }
            NumberAnimation {targets: [thumbs]; properties: "opacity"; from: 1; to:0;   duration: 1500}
            running: true
        }
    }

    Rectangle{
        id:rec1
        z:2
        width: 270 * _width
        height: 40 * _height
        anchors.top: parent


        Image {
            id:home_Image
            width: 15* _width
            height: 15* _height
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 13
            //verticalAlignment: parent.AlignVCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            source: "images/home.png"
            MouseArea{
                anchors.fill:parent
                onClicked: {  stackView.push("qrc:/MainPage.qml") }
            }
        }


        Image {
            id: image
            width: 100* _width
            height: 22* _height
            fillMode: Image.PreserveAspectFit
            anchors.top:parent.top
            anchors.topMargin: 10
            anchors.left:home_Image.right
            anchors.leftMargin: 65*_width
            //verticalAlignment: parent.AlignVCenter
            source: "images/듣고쓰고.png"
        }

        Text{
            text: score
            id:score_Text
            width: 10*_width
            height: 20* _height
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
        }

        Image{
            id: thumbs_image
            width: 20* _width
            height: 20* _height
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right:score_Text.left
            anchors.rightMargin: 10
            source: "images/thumbsup.jpg"
        }


    }

    Rectangle{
        id:rec2
        z:2
        width: 270* _width
        height: 30* _height
        anchors.top: rec1.bottom
        color: "#f5e3e3"

        Text {
            text: "번호"
            id:rec2_text1
            width: 45*_width
            height: 30* _height
            anchors.top: rec1.bottom
            anchors.left: rec2.left
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12*_width
        }

        Text {
            text: "답"
            id:rec2_text2
            width: 90*_width
            height: 30* _height
            anchors.top: rec1.bottom
            anchors.left: rec2_text1.right
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12*_width

        }
        Text {
            text: "내가쓴답"
            id:rec2_text4
            width: 90*_width
            height: 30* _height
            anchors.top: rec1.bottom
            anchors.left: rec2_text2.right
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12*_width

        }

        Text {
            text: "채점"
            id:rec2_text3
            width: 45*_width
            height: 30* _height
            anchors.top: rec1.bottom
            anchors.left: rec2_text4.right
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12*_width

        }




        Rectangle//구분선
        {

            x:parent.width/6
            width:1
            height:parent.height
            color:"black"
        }
        Rectangle//구분선
        {

            x:parent.width/6*5
            width:1
            height:parent.height
            color:"black"
        }
        Rectangle//구분선
        {

            x:parent.width/6*3
            width:1
            height:parent.height
            color:"black"
        }

    }
    Rectangle{

        id:rec3
        z:0
        width: 270* _width
        anchors.top: rec2.bottom

        Item {
            property string temp:"";
            property string listView_source:"";

            id: item2
            z:0
            visible: true
            width: 270* _width
            height: 500*_height
            Component.onCompleted://view가 처음 실행될때 제일 처음으로 불려지는곳
            {

                for(var i=0;i<5;i++)
                {
                    console.log(_tcp._returncorrect(i))
                    console.log(_tcp._returncorrect(i+5))

                    temp=_tcp._returncorrect(i);

                    if(temp=="OK")
                    { listView_source = "qrc:/images/circle.png"; score++}

                    else
                        listView_source ="qrc:/images/check.png";


                    listView.model.append({"num": connectEvent.getListCount(i),
                                              "list_text2": _tcp._GetQuestionList(i),
                                              "ans":listView_source,
                                          "list_text3": _tcp._returncorrect(i+5)})

                    thumbs_animation3.start()
                }
            }

            Component {//리스트 뷰의 틀을 만든다.
                id: contactDelegate

                Item {
                    id:test2
                    width: 270* _width
                    height: 90*_height


                    Image {
                        id:listView_Image
                        width:45* _width
                        height:70
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter;
                        source : "qrc:/images/"+num+".png"
                        fillMode: Image.PreserveAspectFit
                    }

                    Text
                    {
                        id:listView_text2
                        anchors.left: listView_Image.left
                        anchors.leftMargin: 70* _width
                        anchors.verticalCenter: parent.verticalCenter
                        text: list_text2//모델에 매칭이될 변수 listview에 원하는 값을 넣기위해서 설정하는 값
                        font.pointSize:12*_width
                    }

                    Text
                    {
                        id:listView_text3
                        anchors.left: listView_text2.left
                        anchors.leftMargin: 90* _width
                        anchors.verticalCenter: parent.verticalCenter
                        text: list_text3//모델에 매칭이될 변수 listview에 원하는 값을 넣기위해서 설정하는 값
                        font.pointSize:12*_width
                    }


                    Image
                    {
                        id:listView_Image1
                        width:45* _width
                        height:60
                        anchors.left: listView_rec1.left
                        anchors.verticalCenter: parent.verticalCenter;
                        source : ans
                        fillMode: Image.PreserveAspectFit

                    }
                    Rectangle//구분선
                    {

                        width:parent.width
                        anchors.top:parent.top
                        height:1
                        color:"black"
                    }



                    Rectangle//구분선
                    {

                        width:parent.width
                        anchors.bottom:parent.bottom//현재 객체의 아래 기준점을 부모객체의 아래로 잡아주어서 위치가 아래로가게 설정
                        height:1
                        color:"black"
                    }
                    Rectangle//구분선
                    {
                        x:parent.width/6
                        width:1
                        height:parent.height
                        color:"#f3f309"
                    }

                    Rectangle//구분선
                    {
                        x:parent.width/6*3
                        width:1
                        height:parent.height
                        color:"blue"
                    }

                    Rectangle//구분선
                    {
                        id:listView_rec1
                        x:parent.width/6*5
                        width:1
                        height:parent.height
                        color:"red"

                    }




                }
            }




            ListView {
                id:listView
                anchors.fill: parent

                model: ListModel{}//임의로 만들 모델을 넣어준다.
                delegate: contactDelegate
                //delegate란 리스트 한개의 틀(틀을 하나 만들어서 그것들을 여러개 붙여놓은것이 리스트 뷰이다.)

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 600 }
                    NumberAnimation { property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 850 }
                }


            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/
