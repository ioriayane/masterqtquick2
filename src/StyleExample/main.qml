import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
  visible: true
  width: 320
  height: 240
  title: "Style Example"

  menuBar: MenuBar {
    //メニューバーのスタイルを設定            [1]
    style: DarkMenuBarStyle {}
    //1つ目のメニュー
    Menu {
      title: "&File"
      MenuItem { text: "&Open..."; shortcut: StandardKey.Open; enabled: false }
      MenuSeparator {}
      MenuItem { text: "&Quit"; onTriggered: Qt.quit() }
    }
    //2つ目のメニュー
    Menu {
      title: "&Status"
      //2階層目のメニュー1つ目
      Menu {
        title: "Character"
        MenuItem { text: "Miyano"; shortcut: "M"; iconSource: "strawberry.png" }
        MenuItem { text: "Shiraishi"; shortcut: "Ctrl+S"; iconSource: "glasses.png" }
        MenuItem { text: "Echizen"; shortcut: "Shift+E"; iconSource: "skirt.png" }
      }
      //2階層目のメニュー2つ目
      Menu {
        id: contextMenu         //コンテキストメニューとしても使う
        title: "Best place"
        style: DarkMenuStyle {} //コンテキストメニューでも使用するので単体でも指定する  [2]
        //メニューをまとめるためのグループを定義
        ExclusiveGroup { id: group }
        MenuItem { text: "Classroom"; exclusiveGroup: group; checkable: true }
        MenuItem { text: "Pressroom"; exclusiveGroup: group; checkable: true }
        MenuItem { text: "Terrace"; exclusiveGroup: group; checkable: true; checked: true }
      }
    }
  }
  //コンテキストメニューの表示
  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.RightButton
    onClicked: contextMenu.popup()
  }

  Column {
    anchors.centerIn: parent
    spacing: 5

    //テスト用の文字列を表示
    Text {
      id: message
      text: "Style Example"
    }

    //スタイル設定で見た目を変更
    Button {
      //ボタンの文字列
      text: "Click!"
      //ボタン用のスタイル設定            [3]
      style: DarkButtonStyle {}
      //クリックしたらテキストの表示を変更
      onClicked: message.text = "Please let called a master!"
    }
  }
}
