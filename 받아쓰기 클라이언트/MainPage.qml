import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Timeline 1.0
import QtQuick.Controls.Material 2.3

Item {
    //objectName:"mainPage"

    property double _width: width / 270
    property double _height: height / 570
    property string pageName: "mainPage"

    id: page1
    anchors.fill: parent

    Rectangle{
        id: rectangle
        anchors.top: parent.top

        width: parent.width
        height: 42 * _height
        color: "#4DEAEAEA"

        Image{
            source: "images/듣고쓰고.png"
            width: 100 * _width
            height: 22 * _height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

        }
    }

    Button{
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.topMargin: height / 10

        rightPadding: 0
        leftPadding: 0

        height: 50 * _height
        width: 50 * _width
        flat: true

        Image{
            source: "images/트로피.png"
            height: parent.height
            width: parent.width
        }

        onClicked: {
            _tcp._write("ranking/");
            stackView.push("qrc:/Rank.qml")
        }
    }

    Image {
        id: leveltitle
        y: 110 * _height
        width: 90 * _width
        height: 30 * _height

        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/level.png"

    }

    property double top_margin: 20 * _height

    Button {
        id: button
        width: 220 * _width
        height: 100 * _height
        anchors.top: leveltitle.bottom
        anchors.topMargin: top_margin
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle{
            radius: 20
            color: button.down ? "gray":"#f4f1f1"
        }
        Image{
            source: "images/low.png"
            anchors.horizontalCenter: parent.horizontalCenter
            height: 30 * _height
            anchors.verticalCenter: parent.verticalCenter
            width: 180 * _width
        }

        Material.background: Material.color(Material.Grey, Material.Shade50)
        Material.elevation: 4

        onClicked: {
            _tcp._RecvQuestionList("start/1");
            stackView.push("qrc:/Stage1.qml",{text1: "하급"})
        }
    }


    Button {
        id: button1
        width: button.width
        height: button.height
        anchors.top: button.bottom
        anchors.topMargin: top_margin
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle{
            radius: 20
            color: button1.down ? "gray":"#f4f1f1"
        }
        Image{
            source: "images/mid.png"
            anchors.horizontalCenter: parent.horizontalCenter
            height: 30 * _height
            anchors.verticalCenter: parent.verticalCenter
            width: 180 * _width
        }
        Material.background: Material.color(Material.Grey, Material.Shade50)
        Material.elevation: 4

        onClicked: {
            _tcp._RecvQuestionList("start/2");
            stackView.push("qrc:/Stage1.qml",{text1: "중급"})
        }
    }

    Button {
        id: button2
        width: button.width
        height: button.height
        anchors.top: button1.bottom
        anchors.topMargin: top_margin
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle{
            radius: 20
            color: button2.down ? "gray":"#f4f1f1"
        }
        Image{
            source: "images/high.png"
            anchors.horizontalCenter: parent.horizontalCenter
            height: 30 * _height
            anchors.verticalCenter: parent.verticalCenter
            width: 180 * _width
        }

        Material.background: Material.color(Material.Grey, Material.Shade50)
        Material.elevation: 4

        onClicked: {
            _tcp._RecvQuestionList("start/3");
            stackView.push("qrc:/Stage1.qml",{text1: "상급"})
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:480;width:640}
}
##^##*/
