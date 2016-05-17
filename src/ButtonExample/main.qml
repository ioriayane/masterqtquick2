import QtQuick 2.6
import QtQuick.Controls 1.5

ApplicationWindow {
  visible: true
  width: 320
  height: 200
  title: "Button Example"

  //ボタンなどを縦に並べる
  Column {
    anchors.centerIn: parent
    spacing: 5

    //テスト用の文字列を表示
    Text {
      id: message
      text: "Button Example"
    }

    //通常のボタン [1]
    Button {
      //ボタンの文字列
      text: "Click!"
      //クリックしたらテキストの表示を変更
      onClicked: message.text = "Please let called a master!"
    }

    //メニューで複数の機能を選択できるボタン [2]
    Button {
      id: menuButton
      //非表示した子供のTextエレメントの横幅を間接的に使って自分の横幅を調節する [3]
      width: menuButton.implicitWidth + 30
      //ボタンの文字列（メニューが閉じてる状態）
      text: "Select Classmate"
      //メニューの指定 [4]
      menu: Menu {
        //1つ目の項目
        MenuItem {
          text: "Miyano"
          onTriggered: message.text = "Yes Takamori!"
        }
        //2つ目の項目
        MenuItem {
          text: "Shiraishi"
          onTriggered: message.text = "Yes Koiwai!"
        }
        //3つ目の項目
        MenuItem {
          text: "Echizen"
          onTriggered: message.text = "Yes Suwa!"
        }
      }
    }
  }
}
