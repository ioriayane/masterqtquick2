//使用するエレメントに合わせてモジュールをインポートする [1]
import QtQuick 2.6
import QtQuick.Window 2.2

//Windowを作成するエレメント　[2]
Window {
  visible: true                     //作成したウインドウを表示状態にする
  width: 640                        //コンテンツ領域のサイズ
  height: 480
  title: qsTr("Hello World")        //ウインドウのタイトル

  //マウス入力を受け付ける領域の設定
  MouseArea {
    anchors.fill: parent    //親エレメントの全体に配置
    onClicked: {            //クリック時の動作（アプリの終了）
      Qt.quit();
    }
  }

  //文字列を配置
  Text {
    text: qsTr("Hello World") //表示する文字列を指定
    anchors.centerIn: parent  //親のエレメントの中心に配置
  }
}
