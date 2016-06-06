//使用するエレメントに合わせてモジュールをインポートする [1]
import QtQuick 2.6
import QtQuick.Controls 1.5

//メニューバー、ステータスバー、ツールバーを追加できるWindowを作成するエレメント　[2]
ApplicationWindow {
  visible: true                     //作成したウインドウを表示状態にする [3]
  width: 640                        //コンテンツ領域のサイズ [4]
  height: 480
  title: qsTr("Hello World")        //ウインドウのタイトル

  //メニューバーの設定 [5]
  menuBar: MenuBar {
    Menu {                          //メニューに項目「File」を追加
      title: qsTr("File")           //項目の名称を指定
      MenuItem {                    //子項目「Open」を追加
        text: qsTr("&Open")         //子項目の名称を指定
        onTriggered: console.log("Open action triggered");  //選択時の動作（ログ出力）
      }
      MenuItem {                    //子項目「Exit」を追加
        text: qsTr("Exit")          //子項目の名称を指定
        onTriggered: Qt.quit();     //選択時の動作（アプリ終了）
      }
    }
  }

  //文字列を配置 [6]
  Label {
    text: qsTr("Hello World")       //表示する文字列を指定
    anchors.centerIn: parent        //親のエレメントの中心に配置
    //親のエレメントの上側に合わせて配置
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
  }
}
