import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3

ApplicationWindow {
  visible: true
  width: 640;  height: 480
  title: "Drag and Drop Example"

  //プレビューと一覧の配分を変えられる         [1]
  SplitView {
    anchors.fill: parent
    orientation: Qt.Vertical
    //プレビューの表示領域
    Image {
      id: previewImage
      Layout.fillWidth: true                    //横幅はいっぱいに広げる
      Layout.fillHeight: true                   //高さはできるだけ広げる   [2]
      Layout.minimumHeight: parent.height / 3   //親の1/3より小さくしない  [3]
      Layout.margins: 5
      fillMode: Image.PreserveAspectFit         //アスペクト比を維持
      smooth: true
    }
    //ドロップした画像の一覧
    ScrollView {
      id: listScroll
      Layout.fillWidth: true                    //横幅はいっぱいに広げる
      Layout.minimumHeight: parent.height / 3   //親の1/3より小さくしない  [4]
      Layout.margins: 5
      horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOn  //横スクロールバーを常に表示
      RowLayout {
        spacing: 5
        //一覧用のImageをRepeaterで管理
        Repeater {
          id: listRepeater
          model: ListModel { id: listImageModel }   //モデルは空の状態から
          delegate: Image {
            //推奨サイズ                 [5]
            Layout.preferredWidth:
                (listScroll.viewport.height ) * sourceSize.width / sourceSize.height
            Layout.preferredHeight: listScroll.viewport.height
            fillMode: Image.PreserveAspectFit       //アスペクト比を維持
            smooth: true
            source: model.source                    //画像のパスはモデルから取得
            MouseArea {
              anchors.fill: parent
            }
            //ドラッグ＆ドロップ関係
            Drag.active: imageDrag.drag.active          //ドラッグ機能On
            Drag.dragType: Drag.Automatic               //外部へのドラッグ可 [6]
            Drag.mimeData: { "text/uri-list": source }  //MIME情報      [7]
            //ドラッグに必要なマウス処理
            MouseArea {
              id: imageDrag
              anchors.fill: parent
              drag.target: parent             //ドラッグする対象を指定
              onReleased: parent.Drag.drop()  //離したときにドロップの処理を実行
              //クリックされたらプレビューに表示
              onClicked: previewImage.source = parent.source
            }
          }
          //追加されたらプレビューに表示
          onItemAdded: previewImage.source = item.source
        }
      }
    }
  }
  //ドラッグ状態に反応してことを表す四角
  Rectangle {
    id: dropRect
    anchors.fill: parent
    anchors.margins: 5
    radius: 4
    color: "#000000"
    opacity: 0
    states: State {
      //ドラッグ状態で領域内にいたら背景色と文字色を変更
      when: imageDropArea.containsDrag         // [8]
      PropertyChanges { target: dropRect; opacity: 0.5 }
      PropertyChanges { target: message; opacity: 1 }
    }
    //ドラッグ状態で領域内にいるときの説明
    Text {
      id: message
      anchors.centerIn: parent
      color: "white"
      text: "Detecting..."
    }
    //ドロップの受付
    DropArea {                                    // [9]
      id: imageDropArea
      anchors.fill: parent
      keys: ["text/uri-list"]    //受け取るデータを絞る // [10]
      onDropped: {                                // [11]
        if(drop.hasUrls){                         // [12]
          //drop.urlsのパスをプレビュー用のモデルへ追加
          for(var i=0; i<drop.urls.length; i++){
            //簡易的に画像の拡張子に限定
            if(drop.urls[i].indexOf(".bmp") >= 0
                || drop.urls[i].indexOf(".png") >= 0
                || drop.urls[i].indexOf(".jpg") >= 0){
              //モデルへ追加
              listImageModel.append({"source": drop.urls[i]})
            }
          }
        }
        console.debug("accepted : " + drop.accepted)  //イベントを受け入れたか
        console.debug("action : " + drop.action)      //コピーか移動かなど
        console.debug("colorData : " + drop.colorData)//色情報
        console.debug("drag.source : " + drop.source) //ドラッグされたオブジェクト（エレメントなど）
        console.debug("formats : " + drop.formats)    //mime形式のリスト
        console.debug("hasColor : " + drop.hasColor)  //colorDataに値があるか
        console.debug("hasHtml : " + drop.hasHtml)    //htmlに値があるか
        console.debug("hasText : " + drop.hasText)    //textに値があるか
        console.debug("hasUrls : " + drop.hasUrls)    //urlsに値があるか
        console.debug("html : " + drop.html)          //html情報
        console.debug("keys : " + drop.keys)          //データ型など特定するキー情報
        console.debug("proposedAction : " + drop.proposedAction)
        console.debug("supportedActions : " + drop.supportedActions)
        console.debug("text : " + drop.text)          //テキスト情報
        console.debug("urls : " + drop.urls)          //URLのリスト（ファイルパスなど）
        console.debug("x : " + drop.x)
        console.debug("y : " + drop.y)
        console.debug(Qt.CopyAction + "," + Qt.MoveAction + "," + Qt.LinkAction + "," + Qt.IgnoreAction)
      }
    }
  }
}
