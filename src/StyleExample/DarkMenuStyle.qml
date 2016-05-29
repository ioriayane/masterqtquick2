import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

MenuStyle {
  //メニュー全体の背景 [1]
  frame: Rectangle {
    //枠線
    border.width: 1
    border.color: "#444"
    //グラデーションで塗りつぶし
    gradient: Gradient {
      GradientStop { position: 0   ; color: "#aaa" }
      GradientStop { position: 0.4 ; color: "#888" }
      GradientStop { position: 1   ; color: "#666" }
    }
  }

  //区切り [2]
  separator: Item {
    Rectangle {
      anchors.centerIn: parent
      width: parent.width * 0.9
      height: 1
      color: "lightgray"
    }
  }

  //項目の背景 [3]
  itemDelegate.background: Rectangle {
    //枠線（カーソルがのったら表示する）
    border.width: styleData.selected ? 1 : 0
    border.color: "#222"
    //背景色（カーソルが乗ったらグレー。普段は透明）
    gradient: Gradient {
      GradientStop { position: 0   ; color: styleData.selected ? "#ddd" : "transparent" }
      GradientStop { position: 0.4 ; color: styleData.selected ? "#ddd" : "transparent" }
      GradientStop { position: 1   ; color: styleData.selected ? "#aaa" : "transparent" }
    }
    //アイコン [4]
    Image {
      width: height
      anchors.left: parent.left
      anchors.margins: 2
      anchors.verticalCenter: parent.verticalCenter
      source: styleData.iconSource ? styleData.iconSource : ""
    }
    //サブメニューのガイド  [5]
    Image {
      anchors.right: parent.right
      anchors.rightMargin: 5
      anchors.verticalCenter: parent.verticalCenter
      visible: styleData.type === MenuItemType.Menu
      source: styleData.selected ? "sub_sel.png" : "sub_nor.png"
    }
  }

  //項目の文字列  [6]
  itemDelegate.label: Text {
    id: labelText
    width: implicitWidth + 10
    height: implicitHeight + 10
    verticalAlignment: Text.AlignVCenter
    text: formatMnemonic(styleData.text, true)    //表示する文字列を指定
    color: "white"
    states: [ State {
        when: !styleData.enabled   //無効になったらグレー
        PropertyChanges { target: labelText; color: "darkgray" }
      }, State {
        when: styleData.selected   //カーソルがのったら黒
        PropertyChanges { target: labelText; color: "black" }
      }
    ]
  }

  //ショートカットキーの文字列 [7]
  itemDelegate.shortcut: Text {
    id: shortcutText
    verticalAlignment: Text.AlignVCenter
    text: styleData.shortcut                              //ショートカットの文字列を指定
    color: "white"
    states: [ State {
        when: !styleData.enabled   //無効になったらグレー
        PropertyChanges { target: shortcutText; color: "darkgray" }
      }, State {
        when: styleData.selected   //カーソルがのったら黒
        PropertyChanges { target: shortcutText; color: "black" }
      }
    ]
  }

  //チェックマーク [8]
  itemDelegate.checkmarkIndicator: Image {
    visible: styleData.checked
    source: "check.png"
  }

  //サブメニューがあるときのガイドマーク（ダミー） [9]
  itemDelegate.submenuIndicator: Item { }
}
