import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
  visible: true
  width: 640
  height: 480
  title: qsTr("External Drag and Drop")

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 5

    Rectangle {
      id: dropRect
      Layout.fillWidth: true      //横幅はいっぱいに広げる
      Layout.fillHeight: true     //高さはできるだけ広げる
      Layout.preferredHeight: 100 //プレビュー領域と2:1の配分にする
      radius: 4
      color: "#aaaaaa"
      states: State {
        when: imageDropArea.containsDrag
        //ドラッグ状態で領域内にいたら背景色と文字色を変更
        PropertyChanges { target: dropRect; color: "#666666" }
        PropertyChanges { target: message; color: "White" }
      }
      //ドロップするアイテムの説明
      Text {
        id: message
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        text: "Please drop the image here.\n(*.bmp, *.png, *.jpg)"
      }
      //ドロップの受付
      DropArea {
        id: imageDropArea
        anchors.fill: parent
        onDropped: {
          //drop.urlsのパスをプレビュー用のモデルへ追加
          for(var i=0; i<drop.urls.length; i++){
            //簡易的に画像の拡張子に限定
            if(drop.urls[i].indexOf(".bmp") >= 0
                || drop.urls[i].indexOf(".png") >= 0
                || drop.urls[i].indexOf(".jpg") >= 0){
              //モデルへ追加
              previewImageModel.append({"source": drop.urls[i]})
            }
          }
          console.debug("accepted : " + drop.accepted)
          console.debug("action : " + drop.action)
          console.debug("colorData : " + drop.colorData)
          console.debug("drag.source : " + drop.source)
          console.debug("formats : " + drop.formats)  //mime
          console.debug("hasColor : " + drop.hasColor)
          console.debug("hasHtml : " + drop.hasHtml)
          console.debug("hasText : " + drop.hasText)
          console.debug("hasUrls : " + drop.hasUrls)
          console.debug("html : " + drop.html)
          console.debug("keys : " + drop.keys)  //formatsと同じ内容(外部ドロップだけ？）
          console.debug("proposedAction : " + drop.proposedAction)
          console.debug("supportedActions : " + drop.supportedActions)
          console.debug("text : " + drop.text)  //複数のときはカンマ区切り
          console.debug("urls : " + drop.urls)  //URLのリスト
          console.debug("x : " + drop.x)
          console.debug("y : " + drop.y)
        }
      }
    }

    //画像のプレビューをスクロールできるようにする
    ScrollView {
      Layout.fillWidth: true                //横幅はいっぱいに広げる
      Layout.fillHeight: true               //高さはできるだけ広げる
      Layout.preferredHeight: 50            //ドロップ領域と2:1の配分にする
      RowLayout {
        anchors.top: parent.top             //高さはScrollViewに合わせる
        anchors.bottom: parent.bottom
        //プレビュー表示用のImageをRepeaterで管理
        Repeater {
          delegate: Image {
            Layout.preferredWidth: 150              //推奨サイズ
            Layout.preferredHeight: 150
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: model.source                    //画像のパスはモデルから取得

//            Drag.active: xAxisDrag.drag.active
//            //ドロップとの当たり判定の位置
//            Drag.hotSpot.x: width / 2
//            Drag.hotSpot.y: height / 2
//            //ドラッグに必要なマウス処理
//            MouseArea {
//              id: xAxisDrag
//              anchors.fill: parent
//              //ドラッグする対象を指定
//              drag.target: parent
//              //離したときにドロップの処理を実行
//              onReleased: parent.Drag.drop()
//            }
          }
          model: ListModel { id: previewImageModel} //モデルは空の状態から
        }
      }
    }
  }


}
