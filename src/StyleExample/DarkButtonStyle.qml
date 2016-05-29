import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

ButtonStyle {
  //背景のスタイル   [1]
  background: Rectangle {
    //推奨サイズ   [2]
    implicitWidth: 50
    implicitHeight: 25
    //枠線（フォーカスがあると太くなる）
    border.width:  control.activeFocus ? 2 : 1
    border.color: "#444"
    //角丸にする
    radius: 3
    //グラデーションで塗りつぶし [3]
    gradient: Gradient {
      GradientStop { position: 0   ; color: control.pressed ? "#666" : "#aaa" }
      GradientStop { position: 0.4 ; color: control.pressed ? "#888" : "#888" }
      GradientStop { position: 1   ; color: control.pressed ? "#888" : "#666" }
    }
  }
  //文字列のスタイル  [4]
  label: Text {
    //ボタンの中心に表示
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    //Buttonエレメントに指定された文字列を表示  [5]
    text: control.text
    //文字色を白色に
    color: "white"
  }
}
