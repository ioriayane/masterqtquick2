import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Window 2.1

Window {
  id: root
  //ウインドウサイズはメッセージとボタンのサイズに合わせる
  width: content.width + 20
  height: content.height + 20
  //デフォルトをモーダルに変更               [1]
  modality: Qt.ApplicationModal
  title: "About"

  //アイコン　メッセージ
  //     ボタン       な位置関係に並べる
  Column {
    id: content
    anchors.centerIn: parent
    spacing: 15
    Row {
      spacing: 10
      //アイコンを表示
      Image { source: "sweets.png" }
      //メッセージ
      Column {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5
        Text { text: "Tanaka-kun"; font.pointSize: 14 }
        Text { text: "is always sleepy."; font.pointSize: 10 }
      }
    }
    //OKボタン
    Button {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "OK"
      onClicked: {
        //ウインドウを非表示にする          [2]
        root.visible = false
//          root.visibility = Window.Hidden
      }
    }
  }
}
