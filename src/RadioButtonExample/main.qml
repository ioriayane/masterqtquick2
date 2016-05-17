import QtQuick 2.6
import QtQuick.Controls 1.5

ApplicationWindow {
  visible: true
  width: 320
  height: 200
  title: qsTr("Radio Button Example")

  //テスト用の文字列を表示
  Text {
    id: message
    x: 5; y: 5
  }

  //グループボックス
  GroupBox {
    anchors.centerIn: parent
    title: "Favorite Nickname?" //タイトルの文字列
    checkable: true             //タイトル横にチェックボックスを追加して使用可/不可を切り替え可能に
    implicitWidth: 150          //推奨の横幅を指定（タイトルの文字列分を確保）

    //ラジオボタンを縦に並べる
    Column {
      spacing: 5

      //ラジオボタンをまとめるためのグループを定義 [1]
      ExclusiveGroup {
        id: group
        //選択されている項目が変更された [2]
        onCurrentChanged: message.text = "= %1 : %2".arg(current.num).arg(current.text)
      }
      //1つ目の項目 [3]
      RadioButton {
        property int num: 1     //識別用の番号
        text: "Ecchan"          //表示する文字列
        exclusiveGroup: group   //所属するグループの指定 [4]
        checked: true           //1つ目をデフォルト状態にする
      }
      //2つ目の項目
      RadioButton {
        property int num: 2     //識別用の番号
        text: "Tacchan"         //表示する文字列
        exclusiveGroup: group   //所属するグループの指定 [5]
      }
      //3つ目の項目
      RadioButton {
        property int num: 3     //識別用の番号
        text: "Occhan"          //表示する文字列
        exclusiveGroup: group   //所属するグループの指定 [6]
      }

      //現在の選択項目を表示 [7]
      Text {
        text: " > %1 : %2".arg(group.current.num).arg(group.current.text)
      }
    }
  }
}
