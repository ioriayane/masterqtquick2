//使用するエレメントに合わせてモジュールをインポートする [1]
import QtQuick 2.6
import QtQuick.Controls 1.5

//メニューバー、ステータスバー、ツールバーを追加できるWindowを作成するエレメント　[2]
ApplicationWindow {
  //作成したウインドウを表示状態にする [3]
  visible: true
  //コンテンツ領域のサイズ [4]
  width: 640
  height: 480
  //ウインドウのタイトル
  title: qsTr("Hello World")

  //メニューバーの設定 [5]
  menuBar: MenuBar {
    //メニューに項目「File」を追加
    Menu {
      //項目の名称を指定
      title: qsTr("File")
      //子項目「Open」を追加
      MenuItem {
        //子項目の名称を指定
        text: qsTr("&Open")
        //クリックされたときの動作を指定（ログ出力）
        onTriggered: console.log("Open action triggered");
      }
      //子項目「Exit」を追加
      MenuItem {
        //子項目の名称を指定
        text: qsTr("Exit")
        //クリックされた時の動作を指定（アプリの終了）
        onTriggered: Qt.quit();
      }
    }
  }

  //文字列を配置 [6]
  Label {
    //表示する文字列を指定
    text: qsTr("Hello World")
    //親のエレメントの中心に配置
    anchors.centerIn: parent
    //親のエレメントの上側に合わせて配置
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
  }
}
