import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import TCP 1.0
//import QtQuick.Dialogs 1.2
import "."

Item {
    id: drawingItem

    property string text1
    property color paintColor: "black"
    property int toolsize: 5
    property double _width: drawingItem.width / 270
    property double _height: drawingItem.height / 570
    property int count: 0

    anchors.fill: parent
    property alias home_Image: home_Image


    Component.onCompleted://view가 처음 실행될때 제일 처음으로 불려지는곳
    {
        canvus_animation.start()
        count++;

    }

    ParallelAnimation{
        id: canvus_animation
        NumberAnimation {targets: [canvas_rec1,canvas_rec2,canvas_rec3,canvas_rec4]; property: "opacity"; from: 0; to: 1.0; duration: 600}
        NumberAnimation {targets: [canvas_rec1,canvas_rec2,canvas_rec3,canvas_rec4]; property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 850 }
        running: true
    }



    Rectangle{
        id: rec1
        width: 270 *_width
        height: 40*_height
        anchors.top: parent.top
        Image {
            id:home_Image
            width: 15*_width
            height: 15*_height
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 13*_height
            anchors.left: parent.left
            anchors.leftMargin: 10*_width
            source: "images/home.png"
            MouseArea{
                anchors.fill:parent
                onClicked: {  stackView.pop()}
            }
        }
        Image {
            id: title_image
            width: 100*_width
            height: 22*_height
            fillMode: Image.PreserveAspectFit
            anchors.top:parent.top
            anchors.topMargin: 10*_height
            anchors.left:home_Image.right
            anchors.leftMargin: 65*_width
            source: "images/듣고쓰고.png"
        }
    }

    Rectangle{
        id:rec2_sound
        width: 270*_width
        height: 100*_height
        anchors.top: rec1.bottom
        color: "#f4f1f1"
        radius: 20

        Text {
            id: level_text
            anchors.left: rec2_sound.left
            anchors.leftMargin : 10*_width
            width: 195*_width
            height: 85*_height
            text: qsTr(text1+" "+count.toString()+"단계")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode:Text.WrapAnywhere
            style: Text.Raised
            font.pointSize: 20*_width
        }

        Image {
            id: sound_image
            width: 50*_width
            height: 50*_height
            fillMode: Image.PreserveAspectFit
            anchors.top:parent.top
            anchors.topMargin: 20*_height
            anchors.right: parent.right
            anchors.rightMargin: 20*_width
            source: "images/headset.png"

            MouseArea{
                anchors.fill:parent
                onClicked: {
                    _tcp._PlaySound(_tcp._GetQuestionList(count-1));
                }
            }
        }


    }

    Rectangle{
        id : tool_rec
        height: 80*_height
        anchors{
            top: rec2_sound.bottom
            left: parent.left
            right: parent.right
        }

        Button{
            id: pen_rec
            anchors.left: parent.left
            anchors.leftMargin: 55*_width
            anchors.top: parent.top
            anchors.topMargin: 20*_height
            width: 40*_width
            height: 40*_height

            background: Rectangle{
                radius: 20
                color: pen_rec.down ? "gray":"#f4f1f1"
            }

            Image{
                anchors.fill: parent
                source: "images/pencil.png"
            }
            onClicked: {
                paintColor= "black"
                toolsize =5
            }
        }

        Button{
            id: eraser_rec
            anchors.left: pen_rec.right
            anchors.leftMargin: 20*_width
            anchors.top: parent.top
            anchors.topMargin: 20*_height
            width: 40*_width
            height: 40*_height
            padding: 3


            background: Rectangle{
                radius: 20
                color: eraser_rec.down ? "gray":"#f4f1f1"
            }
            Image{
                anchors.fill: parent
                source: "images/eraser.png"


            }
            onClicked: {
                paintColor= "white"
                toolsize =20
            }
        }


        Button{
            id: allclear_btn
            anchors.left: eraser_rec.right
            anchors.leftMargin: 20*_width
            anchors.top: parent.top
            anchors.topMargin: 20*_height
            width: 40*_width
            height: 40*_height
            padding: 3

            background: Rectangle{
                radius: 20
                color: allclear_btn.down ? "gray":"#f4f1f1"
            }

            Image{
                anchors.fill: parent
                source: "images/allclear.png"
            }

            onClicked: {
                canvas.clear_canvas()
                canvas2.clear_canvas2()
                canvas3.clear_canvas3()
                canvas4.clear_canvas4()
            }

        }
    }



    Rectangle{
        id:main_rec
        anchors.top: tool_rec.bottom
        height: 270*_height
        width: 270*_width
        color: "lightblue"
        radius: 20
    }

    Rectangle{
        id : canvas_rec1
        width: 100*_width
        height: 100*_height
        anchors.top: main_rec.top
        anchors.topMargin:30*_height
        anchors.left: main_rec.left
        anchors.leftMargin:25*_width
        //        radius: 20

        Canvas {
            id: canvas
            property real lastX
            property real lastY
            property color color: paintColor
            anchors.fill: canvas_rec1

            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = toolsize
                ctx.strokeStyle = canvas.color
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area.mouseX
                lastY = area.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()

                function testfunc(){
                    var ctx = getContext('2d')
                    ctx.lineWidth = 1000
                    ctx.strokeStyle = "red"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(20, 20)
                    ctx.stroke()

                }

            }


            MouseArea {
                id: area
                anchors.fill: parent
                onPressed: {
                    canvas.lastX = mouseX
                    canvas.lastY = mouseY
                }
                onPositionChanged: {
                    canvas.requestPaint()
                }
            }

            function clear_canvas() {
                var ctx = getContext("2d");
                ctx.reset();
                canvas.requestPaint();
            }

        }

    }

    Rectangle{
        id : canvas_rec2
        width: 100*_width
        height: 100*_height
        anchors.top: main_rec.top
        anchors.topMargin:30*_height
        anchors.right: main_rec.right
        anchors.rightMargin:25*_width
        //        radius: 20

        Canvas {
            id: canvas2
            property real lastX
            property real lastY
            property color color: paintColor
            anchors.fill: canvas_rec2

            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = toolsize
                ctx.strokeStyle = canvas2.color
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area2.mouseX
                lastY = area2.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }

            MouseArea {
                id: area2
                anchors.fill: parent
                onPressed: {
                    canvas2.lastX = mouseX
                    canvas2.lastY = mouseY
                }
                onPositionChanged: {
                    canvas2.requestPaint()
                }
            }

            function clear_canvas2() {
                var ctx = getContext("2d");
                ctx.reset();
                canvas2.requestPaint();
            }
        }
    }

    Rectangle{
        id : canvas_rec3
        width: 100*_width
        height: 100*_height
        anchors.bottom: main_rec.bottom
        anchors.bottomMargin:30*_height
        anchors.left: main_rec.left
        anchors.leftMargin: 25*_width
        //        radius: 20
        Canvas {
            id: canvas3
            property real lastX
            property real lastY
            property color color: paintColor
            anchors.fill: canvas_rec3

            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = toolsize
                ctx.strokeStyle = canvas3.color
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area3.mouseX
                lastY = area3.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }

            MouseArea {
                id: area3
                anchors.fill: parent
                onPressed: {
                    canvas3.lastX = mouseX
                    canvas3.lastY = mouseY
                }
                onPositionChanged: {
                    canvas3.requestPaint()
                }
            }

            function clear_canvas3() {
                var ctx = getContext("2d");
                ctx.reset();
                canvas3.requestPaint();
            }
        }
    }

    Rectangle{
        id : canvas_rec4
        width: 100*_width
        height: 100*_height
        anchors.bottom: main_rec.bottom
        anchors.bottomMargin:30*_height
        anchors.right: main_rec.right
        anchors.rightMargin:25*_width
        //        radius: 20
        Canvas {
            id: canvas4
            property real lastX
            property real lastY
            property color color: paintColor
            anchors.fill: canvas_rec4

            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = toolsize
                ctx.strokeStyle = canvas4.color
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area4.mouseX
                lastY = area4.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }

            MouseArea {
                id: area4
                anchors.fill: parent
                onPressed: {
                    canvas4.lastX = mouseX
                    canvas4.lastY = mouseY
                }
                onPositionChanged: {
                    canvas4.requestPaint()
                }
            }

            function clear_canvas4() {
                var ctx = getContext("2d");
                ctx.reset();
                canvas4.requestPaint();
            }
        }
    }



//    Popup{
//        id:submit
//        width: parent.width/2
//        height: parent.height/6
//        anchors.centerIn: parent
//        modal: true


//        Text{
//            id:title
//            anchors.horizontalCenter: parent
//            anchors.top: parent.top
//            text: "제출하실?"
//        }
//        Button{
//            height: 50
//            width: parent.width/2-10
//            anchors.left: parent.left
//            anchors.leftMargin: 5
//            anchors.bottom: parent.bottom
//            text: "OK"
//            onClicked:{
//                submit.close();
//                _tcp._SendImage();
//                stackView.push("AnswerSheet.qml");
//            }
//        }

//        Button{
//            height: 50
//            width: parent.width/2-10
//            anchors.right: parent.right
//            anchors.rightMargin: 5
//            anchors.bottom: parent.bottom
//            text: "Cancel"
//            onClicked:{
//                popup.close();
//            }
//        }
//    }


    Popup {
        id:submit

        property double _width: parent.width / 270
        property double _height: parent.height / 570

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
            text: "제출하시겠습니까?"
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
                submit.close();
                _tcp._SendImage();
                stackView.push("AnswerSheet.qml");
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
                submit.close()
            }
        }
    }


    Button {
        id: button
        width: 270*_width
        height: 30*_height
        text: qsTr("다 음")
        anchors.bottom: parent.bottom
        font.bold: true
        onClicked: {
            if(count<=5)
            {
                //                count++;
                canvas_rec1.grabToImage(function(result){result.saveToFile("/storage/emulated/0/QT/"+count+"_1"+".PNG");});
                canvas_rec2.grabToImage(function(result){result.saveToFile("/storage/emulated/0/QT/"+count+"_2"+".PNG");});
                canvas_rec3.grabToImage(function(result){result.saveToFile("/storage/emulated/0/QT/"+count+"_3"+".PNG");});
                canvas_rec4.grabToImage(function(result){result.saveToFile("/storage/emulated/0/QT/"+count+"_4"+".PNG");});
                if(count==5)
                    submit.open();
                else
                    stackView.replace("qrc:/Stage1.qml",{count:count,text1:text1});
            }

        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
