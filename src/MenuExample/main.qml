import QtQuick 2.6
import QtQuick.Controls 1.5

ApplicationWindow {
  visible: true
  width: 320
  height: 200
  title: "Menu Example"

  //メニューバーを作成
  menuBar: MenuBar {
    //1つ目のメニュー
    Menu {
      title: "&File"
      //ファイルを開く
      MenuItem {
        text: "&Open..."
        shortcut: StandardKey.Open            //ショートカットの設定  [1]
        onTriggered: message.text = "Open!!"
      }
      //区切り線
      MenuSeparator {}
      //最近選択した項目
      Menu {
        id: recentItem
        title: "&Recent"
        //登録されるまで無効
        enabled: recentItem.items.length > 0
        //テンプレートにしたMenuItemを動的生成と管理           [2]
        Instantiator {
          //選択した項目の内容管理
          model: ListModel { id: recentItemModel }
          //登録する項目のテンプレート                      [3]
          MenuItem {
            text: model.text
            iconSource: model.icon
            onTriggered: message.text = "recent = %1".arg(text)
          }
          //モデルの内容の変化に応じて追加と削除              [4]
          onObjectAdded: recentItem.insertItem(index, object)
          onObjectRemoved: recentItem.removeItem(object)
        }
        //最近選択した項目へ登録する         [5]
        function addRecentItem(text, icon){
          //Instantiatorのモデルへ追加
          recentItemModel.insert(0, {"text": text, "icon": icon + ""})
          //5つより多くなったら最後を1つ消す
          if(recentItemModel.count > 5){
            recentItemModel.remove(recentItemModel.count-1)
          }
        }
      }
      //区切り線
      MenuSeparator {}
      //アプリケーションを終了
      MenuItem {
        text: "&Quit"
        shortcut: StandardKey.Quit            //ショートカットの設定 [6]
        onTriggered: Qt.quit()
      }
    }
    //2つ目のメニュー
    Menu {
      title: "&Status"
      //2階層目のメニュー1つ目
      Menu {
        title: "Character"
        MenuItem {
          text: "Miyano"
          shortcut: "M"                 //ショートカットの設定（小文字のm）     [8]
          iconSource: "strawberry.png"  //アイコンの設定                 [9]
          onTriggered: recentItem.addRecentItem(text, iconSource)  //[10]
        }
        MenuItem {
          text: "Shiraishi"
          shortcut: "Ctrl+S"            //ショートカットの設定             [11]
          iconSource: "macaroon.png"    //アイコンの設定                 [12]
          onTriggered: recentItem.addRecentItem(text, iconSource) //[13]
        }
        MenuItem {
          text: "Echizen"
          shortcut: "Shift+E"           //ショートカットの設定              [14]
          iconSource: "rabbit.png"      //アイコンの設定                 [15]
          onTriggered: recentItem.addRecentItem(text, iconSource) //[16]
        }
      }
      //2階層目のメニュー2つ目
      Menu {
        id: contextMenu       //コンテキストメニューとしても使う  [17]
        title: "Best place"
        //メニューをまとめるためのグループを定義 [18]
        ExclusiveGroup {
          id: group
          //選択されている項目が変更された
          onCurrentChanged: message.text = "Best place is %1".arg(current.text)
        }
        MenuItem {
          text: "Classroom"         //表示する文字列
          exclusiveGroup: group     //所属するグループの指定     [19]
          checkable: true           //チェックできるように設定
          checked: true             //1つ目をデフォルト状態にする
        }
        MenuItem {
          text: "Pressroom"         //表示する文字列
          exclusiveGroup: group     //所属するグループの指定     [20]
          checkable: true           //チェックできるように設定
        }
        MenuItem {
          text: "Terrace"           //表示する文字列
          exclusiveGroup: group     //所属するグループの指定     [21]
          checkable: true           //チェックできるように設定
        }
      }
    }
  }

  //テスト用の文字列を表示
  Text {
    id: message
    anchors.centerIn: parent
    text: "Menu Example"
  }

  //マウス入力を受け付ける [22]
  MouseArea {
    anchors.fill: parent              //ウインドウ全体
    acceptedButtons: Qt.RightButton   //右クリックのみ
    //クリック時の処理
    onClicked: {
      //メニューバーの一部をポップアップ  [23]
      contextMenu.popup()
    }
  }
}
