import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
  visible: true
  width: 640
  height: 480
  title: "Calendar Example"

  //日付の文字列を作る
  function makeDateString(d){
    return "%1/%2/%3".arg(d.getFullYear()).arg(d.getMonth()+1).arg(d.getDate())
  }

  //日付の入力エリア
  TextField {
    id: inputField
    readOnly: true
    horizontalAlignment: Text.AlignHCenter
    Component.onCompleted: {
      var d = new Date()
      //未入力状態のときのテキストに今日の日付を設定
      placeholderText = makeDateString(new Date())
    }
    MouseArea {
      anchors.fill: parent
      onClicked: inputCalendar.visible = !inputCalendar.visible
    }
  }
  Calendar {
    id: inputCalendar
    width: 150
    height: 170
    anchors.left: inputField.left
    anchors.top: inputField.bottom
    //    visible: false
    //    weekNumbersVisible: true
    //    dayOfWeekFormat: Locale.LongFormat

    //選択した日付をテキストボックスに入力
    onClicked: {
      inputField.text = makeDateString(date)
      visible = false
    }

    style: CalendarStyle {
      //グリッドの色
      //      gridColor: "white"
      //グリッドの表示非表示
      gridVisible: false
      //ナビゲーションバー
      navigationBar: Rectangle {
        height: 20
        RowLayout {
          anchors.fill: parent
          anchors.margins: 1
//          //前の年へのボタン
//          Button {
//            text: "<<"
//            Layout.fillHeight: true
//            Layout.preferredWidth: 20
//            onClicked: inputCalendar.showPreviousYear()
//          }
          //前の月へのボタン
          Button {
            text: "<"
            Layout.fillHeight: true
            Layout.preferredWidth: 20
            onClicked: inputCalendar.showPreviousMonth()
          }
          //表示中の月の表示
          Text {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: styleData.title
          }
          //次の月へのボタン
          Button {
            text: ">"
            Layout.fillHeight: true
            Layout.preferredWidth: 20
            onClicked: inputCalendar.showNextMonth()
          }
//          //次の年へのボタン
//          Button {
//            text: ">>"
//            Layout.fillHeight: true
//            Layout.preferredWidth: 20
//            onClicked: inputCalendar.showNextYear()
//          }
        }
      }

      //曜日のマスの設定
      dayOfWeekDelegate: Text {
        height: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: dayOfWeekString(styleData.dayOfWeek)
        function dayOfWeekString(id){
          var str;
          switch(id){
          case Locale.Sunday:   str="Su"; break;
          case Locale.Monday:   str="Mo"; break;
          case Locale.Tuesday:  str="Tu"; break;
          case Locale.Wednesday:str="We"; break;
          case Locale.Thursday: str="Th"; break;
          case Locale.Friday:   str="Fr"; break;
          case Locale.Saturday: str="Sa"; break;
          default:              str="";   break;
          }
          return str
        }
      }

      //日付のマスの設定
      dayDelegate: Rectangle {
        //背景色のグラデーション（標準は無色）
        gradient: Gradient {
          GradientStop { position: 0; color: "#ffffff" }
          GradientStop { id: dayGradi; position: 1; color: "#eeeeee" }
        }
        //マスの状態で表示を変更する
        states: [ State {
            when: styleData.selected  //選択箇所のとき
            PropertyChanges { target: dayGradi; color: "#66ff0000" }
          }
          ,State {
            when: styleData.hovered   //マウスオーバーのとき
            PropertyChanges { target: dayGradi; color: "#66ffaa00" }
          }
          ,State {
            when: styleData.today     //今日のとき
            PropertyChanges { target: dayGradi; color: "#220000ff" }
          }
        ]
        //日付の数字
        Label {
          text: styleData.date.getDate()
          anchors.centerIn: parent
          color: styleData.visibleMonth ? "black" : "lightGray" //表示中の月のときハッキリ
          font.pointSize: 8
        }
        //マスの枠線（右）
        Rectangle {
          width: 1
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.topMargin: 2
          opacity: 0.5
          color: "#000066"
        }
        //マスの枠線（下）
        Rectangle {
          height: 1
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          anchors.leftMargin: 2
          opacity: 0.5
          color: "#000066"
        }
      }
    }
  }
}
