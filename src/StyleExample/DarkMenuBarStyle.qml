import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

MenuBarStyle {
  //全部のメニューに設定するスタイル     [1]
  menuStyle: DarkMenuStyle {}
  //メニュー全体の背景              [2]
  background: Rectangle {
    gradient: Gradient {
      GradientStop { position: 0   ; color: "#aaa" }
      GradientStop { position: 0.4 ; color: "#888" }
      GradientStop { position: 1   ; color: "#666" }
    }
  }
  //テキスト                      [3]
  itemDelegate: Rectangle {
    //文字列のサイズより少し大きく      [4]
    implicitWidth: label.implicitWidth + 10
    implicitHeight: label.implicitHeight + 10
    //枠線（カーソルがのったら表示する）
    border.width: styleData.selected ? 1 : 0
    border.color: "#222"
    //背景色（カーソルがのったらグレー。普段は透明）
    gradient: Gradient {
      GradientStop { position: 0   ; color: styleData.selected ? "#ddd" : "transparent" }
      GradientStop { position: 0.4 ; color: styleData.selected ? "#ddd" : "transparent" }
      GradientStop { position: 1   ; color: styleData.selected ? "#aaa" : "transparent" }
    }
    Text {
      id: label
      anchors.centerIn: parent
      text: formatMnemonic(styleData.text, true)    //文字列を指定
      color: styleData.selected ? "black" : "white" //カーソルがのったら黒
    }
  }
}
