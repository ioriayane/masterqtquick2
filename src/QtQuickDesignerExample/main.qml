import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.2

ApplicationWindow {
  visible: true
  width: 300
  height: 200
  title: qsTr("Hello World")

  menuBar: MenuBar {
    Menu {
      title: qsTr("File")
      MenuItem {
        //メニューの項目をチェック可能状態にする
        id: menuButtonCheckable
        text: qsTr("Button Checkable")
        checkable: true
      }
      MenuItem {
        text: qsTr("Exit")
        onTriggered: Qt.quit();
      }
    }
  }

  MainForm {
    anchors.fill: parent
    //メニューのチェック状態でモード切り替え [1]
    button1.checkable: menuButtonCheckable.checked
    button1.onClicked: {
      //通常ボタンのときだけダイアログ表示
      if(!button1.checkable)
        messageDialog.show(qsTr("Button 1 pressed"))
    }
    //メニューのチェック状態でモード切り替え
    button2.checkable: menuButtonCheckable.checked
    button2.onClicked: {
      if(!button2.checkable)
        messageDialog.show(qsTr("Button 2 pressed"))
    }
  }

  MessageDialog {
    id: messageDialog
    title: qsTr("May I have your attention, please?")

    function show(caption) {
      messageDialog.text = caption;
      messageDialog.open();
    }
  }
}
