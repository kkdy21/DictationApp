import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0

Item {
    id: item2
    width: 270
    height: 570

    anchors.fill: parent

    property double _width: width / 270
    property double _height: height / 570

    Image {
        id: image
        width: 210
        height: 61
        anchors.top: parent.top
        source: "images/듣고쓰고.png"
        anchors.topMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Item{
        id: item1
        anchors.top: image.bottom
        anchors.topMargin: 80

        anchors.horizontalCenter: parent.horizontalCenter

        TextField {
            id: textField
            x: 20
            width: 230
            height: 40
            opacity: 0
            anchors.top: parent.top
            anchors.topMargin: 10
            leftPadding: 15
            topPadding: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle{
                radius: 7
                border.width: 1
            }
            placeholderText: qsTr("아이디")
        }

        TextField {
            id: textField2
            width: 230
            height: 40
            opacity: 1
            anchors.top: textField.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            leftPadding: 12
            topPadding: 20
            placeholderText: qsTr("비밀번호")
            background: Rectangle{
                radius: 7
                border.width: 1
            }
            anchors.topMargin: 10
        }

        TextField {
            id: textField3
            width: 230
            height: 40
            opacity: 1
            anchors.top: textField2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            leftPadding: 12
            topPadding: 20
            placeholderText: qsTr("전화번호")
            background: Rectangle{
                radius: 7
                border.width: 1
            }
            anchors.topMargin: 10
        }

        Button {
            id: button
            x: 15
            width: 230
            height: 40
            opacity: 0
            text: qsTr("가입하기")
            anchors.top: textField3.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: parent.down ? "#bbbbbb" : "#f6f6f6"
                radius: 5
            }
        }
    }

    Component.onCompleted: {
        Qt.inputMethod.visibleChanged.connect(showKeyboardStats)
    }

    function showKeyboardStats(){
        if(Qt.inputMethod.visible)
        {
            clickedEvent.start()
            clickedEvent1.start()
        }
        else
        {
            clickedEvent3.start()
            clickedEvent4.start()
        }
    }

    NumberAnimation { id:clickedEvent; target: item1; properties: "anchors.topMargin"; duration: 200; from: 80; to:20; }
    NumberAnimation { id:clickedEvent1; target: image; properties: "anchors.topMargin"; duration: 200; from: 80; to:20; }
    NumberAnimation { id:clickedEvent3; target: image; properties: "anchors.topMargin"; duration: 200; from: 20; to:80; }
    NumberAnimation { id:clickedEvent4; target: item1; properties: "anchors.topMargin"; duration: 200; from: 20; to:80; }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: true
                duration: 1500
                loops: 1
                to: 1500
                from: 0
            }
        ]
        startFrame: 0
        endFrame: 1500
        enabled: true

        KeyframeGroup {
            target: textField
            property: "opacity"

            Keyframe {
                easing.bezierCurve: [0.941,-0.246,0.8,0.8,1,1]
                frame: 170
                value: 0
            }

            Keyframe {
                frame: 479
                value: 1
            }
        }

        KeyframeGroup {
            target: textField2
            property: "anchors.topMargin"

            Keyframe {
                frame: 0
                value: -40
            }
            Keyframe {
                frame: 500
                value: -40
            }
            Keyframe {
                frame: 900
                value: 20
            }
        }

        KeyframeGroup {
            target: button
            property: "anchors.topMargin"

            Keyframe {
                frame: 0
                value: -40
            }
            Keyframe {
                frame: 800
                value: -40
            }
            Keyframe {
                frame: 1200
                value: 20
            }
        }

        KeyframeGroup {
            target: textField2
            property: "opacity"

            Keyframe {
                frame: 600
                value: 0
            }

            Keyframe {
                frame: 900
                value: 1
            }
        }

        KeyframeGroup {
            target: button
            property: "opacity"

            Keyframe {
                frame: 900
                value: 0
            }

            Keyframe {
                frame: 1200
                value: 1
            }

        }
    }
}




