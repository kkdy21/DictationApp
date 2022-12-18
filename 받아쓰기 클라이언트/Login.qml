import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0
import QtQuick.Controls.Material 2.3
import TCP 1.0


Item {
    property double _width: width / 270
    property double _height: height / 570
    property string pageName: "loginPage"



    id: item111
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
    Item{
        id: item2
        anchors.top: image.bottom
        anchors.topMargin: 80 * _height
        anchors.horizontalCenter: parent.horizontalCenter

        // 아이디 입력
        TextField {
            id: input_ID
            width: 200 * _width
            height: 40 * _height
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 12 * _height
            placeholderText: qsTr("아이디")
        }

        // 비밀번호 입력
        TextField {
            id: input_PW
            width: input_ID.width
            height: input_ID.height
            anchors.top: input_ID.bottom
            anchors.topMargin: 20 * _height
            echoMode: TextInput.Password
            font.pointSize: 12 * _height
            placeholderText: qsTr("비밀번호")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // 로그인 버튼
        Button {
            id: button
            width: input_ID.width
            height: input_ID.height
            opacity: 0
            text: qsTr("로그인")
            anchors.top: input_PW.bottom
            anchors.topMargin: 10 * _height
            anchors.horizontalCenter: parent.horizontalCenter

            Material.background: "#ffffff"
            onClicked: {_tcp._Login(input_ID.text, input_PW.text)}
        }

        // 회원가입 버튼
        Button {
            id: button1
            width: input_ID.width
            height: input_ID.height
            text: qsTr("회원가입")
            anchors.top: button.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 5 * _height

            onClicked: { stackView.push(join);                }
        }

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
        targets: [image,item2]
        property: "anchors.topMargin"
        to: 20 * _height
        duration: 200
    }
    NumberAnimation{
        id : keyboardoff
        targets: [image,item2]
        property: "anchors.topMargin"
        to: 80 * _height
        duration: 200
    }
    // 시작 애니메이션
    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: true
                duration: 3000
                loops: 1
                to: 3000
                from: 0
            }
        ]
        endFrame: 3000
        enabled: true
        startFrame: 0

        KeyframeGroup {
            target: input_ID
            property: "opacity"

            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 1000
            }

            Keyframe {
                value: 0
                frame: 403
            }
        }

        KeyframeGroup {
            target: input_PW
            property: "opacity"

            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 1398
            }

            Keyframe {
                value: 0
                frame: 598
            }
        }

        KeyframeGroup {
            target: button
            property: "opacity"

            Keyframe {
                value: 0
                frame: 800
            }

            Keyframe {
                value: 1
                frame: 1600
            }

            Keyframe {
                value: 0
                frame: 0
            }
        }

        KeyframeGroup {
            target: image
            property: "x"

            Keyframe {
                value: parent.width
                frame: 0
            }

            Keyframe {
                easing.bezierCurve: [0.755,-0.233,0.782,0.968,1,1]
                value: (parent.width-image.width) / 4
                frame: 398
            }

            Keyframe {
                value: (parent.width-image.width) / 2
                frame: 500
            }
        }

        KeyframeGroup {
            target: button1
            property: "opacity"

            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 1801
            }

            Keyframe {
                value: 0
                frame: 1000
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}D{i:1}D{i:3}D{i:4}D{i:5}
D{i:6}D{i:9}
}
##^##*/
