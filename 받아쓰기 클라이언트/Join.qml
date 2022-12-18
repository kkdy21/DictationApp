import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0
import QtQuick.Controls.Material 2.3


Item {
    property double _width: width / 270
    property double _height: height / 570

    id: join
    width: 270
    height: 570
    anchors.fill: parent

    // 메인 아이콘
    Image {
        id: image
        width: 230 * _width
        height: 100 * _height
        x: (parent.width-width) / 2
        anchors.top: parent.top
        source: "images/듣고쓰고.png"
        anchors.topMargin: 80 * _height

        fillMode: Image.PreserveAspectFit
    }

    // -
    Item {
        id: item3
        anchors.top: image.bottom
        anchors.topMargin: 80 * _height
        anchors.horizontalCenter: parent.horizontalCenter

        // 이름 입력
        TextField {
            id: input_NAME
            width: 200 * _width
            height: 40 * _height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 12 * _height
            placeholderText: qsTr("이름")
        }

        // 아이디 입력
        TextField {
            id: input_ID
            width: input_NAME.width
            height: input_NAME.height
            anchors.top: input_NAME.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10 * _height
            font.pointSize: 12 * _height
            placeholderText: qsTr("아이디")
        }

        // 비밀번호 입력
        TextField {
            id: input_PW
            width: input_NAME.width
            height: input_NAME.height
            anchors.top: input_ID.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10 * _height
            echoMode: TextInput.Password
            font.pointSize: 12 * _height
            placeholderText: qsTr("비밀번호")
        }

        // 가입하기 버튼
        Button {
            id: button
            width: input_NAME.width
            height: input_NAME.height
            text: qsTr("가입하기")
            anchors.top: input_PW.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10 * _height
            onClicked: {_tcp._Account(input_ID.text, input_PW.text)}
        }
    }

    function test(msg)
    {


        if(msg === "1")
            input_NAME.text = "성공"
        else if(msg === "0")
            input_NAME.text = "실패"
        else
            input_NAME.text = "중복"
    }

    // 키보드 인식
    Component.onCompleted: {
        Qt.inputMethod.visibleChanged.connect(showKeyboardStats)
    }

    function showKeyboardStats(){
        if(Qt.inputMethod.visible)
        {
            keyboardon.start()
        }
        else
        {
            keyboardoff.start()
        }
    }

    // 애니메이션
    // 키보드 인식 UI 사이즈 변경
    NumberAnimation{
        id : keyboardon
        targets: [image,item3]
        property: "anchors.topMargin"
        to: 20 * _height
        duration: 200
    }
    NumberAnimation{
        id : keyboardoff
        targets: [image,item3]
        property: "anchors.topMargin"
        to: 80 * _height
        duration: 200
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}
}
##^##*/
