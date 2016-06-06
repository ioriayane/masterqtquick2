//使用するエレメントに合わせてモジュールをインポートする [1]
import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.2

//メニューバー、ステータスバー、ツールバーを追加できるWindowを作成するエレメント
ApplicationWindow {
  visible: true                     //作成したウインドウを表示状態にする
  width: 640                        //コンテンツ領域のサイズ
  height: 480
  title: qsTr("Hello World")        //ウインドウのタイトル

  //メニューバーの設定
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
  //Qt Quickデザイナーで編集するフォームを配置 [2]
  MainForm {
    anchors.fill: parent
    //ボタンのクリックシグナル    [3]
    button1.onClicked: messageDialog.show(qsTr("Button 1 pressed"))
    button2.onClicked: messageDialog.show(qsTr("Button 2 pressed"))
  }
  //メッセージダイアログ
  MessageDialog {
    id: messageDialog
    title: qsTr("May I have your attention, please?")
    //ダイアログのメッセージを変更して表示
    function show(caption) {
      messageDialog.text = caption;
      messageDialog.open();
    }
  }
}
