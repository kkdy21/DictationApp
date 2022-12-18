import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import TCP 1.0
import QtQuick.Dialogs 1.2

Window {
    width: 270
    height: 570
    visible: true
    title: qsTr("Hello World")

    //QML 코드
    StackView{
        id:stackView
        anchors.fill: parent

        initialItem: login

        // 시작 페이지
        Login {
            id : login
        }
    }

    Component{
        id : join

        Join {}
    }

    Component{
        id : main_page

        MainPage {}
    }

    // C++ 코드
    TCP{
        id :_tcp
        onLoginStatus : {
            if(msg == "1")
                stackView.push("qrc:/MainPage.qml")
        }

        onAccountStatus: {
            if(msg == "1")
                stackView.push("qrc:/Login.qml")
        }
    }

    property double _width: width / 270
    property double _height: height / 570

    Popup {
        id:popup



        modal: true
        width: 180 * _width
        height: 120 * _height
        anchors.centerIn: parent

        background: Rectangle{
            radius: 20
            color: "#f4f1f1"
            border.width: 1
        }

        Text {
            id: iii
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 5 * _height

            font.pixelSize: 30
//            color: "white"
            text: "종료하시겠습니까?"
            font.family: "Arial"
        }

        Button {
            id: yes

            width: 160 * _width
            height: 35 * _height
            anchors.top: iii.bottom
            anchors.topMargin: 10 * _height
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("예")
            background: Rectangle{
                radius: 10
                color: yes.down ? "gray":"#f4f1f1"
            }

            onClicked: {
                _tcp._write("exit/");
                Qt.quit();
            }
        }

        Button {
            id: no

            width: yes.width
            height: yes.height
            anchors.top: yes.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("아니오")

            background: Rectangle{
                radius: 10
                color: no.down ? "gray":"#f4f1f1"
            }
            onClicked: {
                popup.close()
            }
        }
    }


    // 뒤로 가기 버튼
    Component.onCompleted: {
        // Connect to `released` signal and dispatch to `back()`
        contentItem.Keys.released.connect(function(event) {
            if (event.key === Qt.Key_Back) {
                event.accepted = true;
                console.log("************ " + stackView.currentItem.pageName);

                if(stackView.currentItem.pageName === "mainPage"){
                    popup.open();
                }else if(stackView.currentItem.pageName === "loginPage"){
                    _tcp._write("exit/");
                    Qt.quit();
                }else if(stackView.currentItem.pageName !== "answerSheet"){
                    stackView.pop();
                }else{
                    stackView.pop();
                    stackView.pop();

                }
            }
        })
    }
}
