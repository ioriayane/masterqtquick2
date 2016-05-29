import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Dialogs 1.2

ApplicationWindow {
  visible: true
  width: 320
  height: 200
  title: "Dialog Example"

  menuBar: MenuBar {
    Menu {
      title: "&File"
      MenuItem {
        text: "&Exit..."
        onTriggered: confirm.open() //確認ダイアログを開く  [1]
      }
    }
  }
  //ウインドウを閉じるときのシグナル
  onClosing: {
    close.accepted = false    //ウインドウを閉じるのを拒否   [2]
    confirm.open()            //確認ダイアログを開く        [3]
  }
  //確認ダイアログ
  MessageDialog {
    id: confirm
    title: "Exit?"                                          //ダイアログタイトル
    text: "Will you sleep soon?"                            //本文
    icon: StandardIcon.Information                          //アイコン
    standardButtons: StandardButton.Yes | StandardButton.No //表示するボタン [4]
    onYes: Qt.quit()                                        //アプリの終了   [5]
  }
}
