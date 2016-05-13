//使用するエレメントに合わせてモジュールをインポートする [1]
import QtQuick 2.6
import QtQuick.Window 2.2

//Windowを作成するエレメント　[2]
Window {
  //作成したウインドウを表示状態にする
  visible: true

  //マウス入力を受け付ける領域の設定
  MouseArea {
    //親エレメントの全体に配置
    anchors.fill: parent
    //クリックされた時の動作を指定（アプリの終了）
    onClicked: {
      Qt.quit();
    }
  }

  //文字列を配置
  Text {
    //表示する文字列を指定
    text: qsTr("Hello World")
    //親のエレメントの中心に配置
    anchors.centerIn: parent
  }
}
