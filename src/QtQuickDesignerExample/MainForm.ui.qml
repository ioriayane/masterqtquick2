import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import "Parts"

Item {
  id: item1
  width: 640
  height: 480

  property alias button1: button1
  property alias button2: button2


  Image {
    id: image1
    x: 215
    y: 108
    width: 80
    antialiasing: true
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    fillMode: Image.PreserveAspectFit
    source: "cat.png"
  }

  RowLayout {
    anchors.centerIn: parent

    Button {
      id: button1
      text: qsTr("Press Me 1")
    }

    ColorIndicator {
      id: colorIndicator1
      visible: button1.checkable
      on: button1.checked
      Layout.fillHeight: true
    }

    Button {
      id: button2
      text: qsTr("Press Me 2")
    }

    ColorIndicator {
      id: colorIndicator2
      visible: button2.checkable
      on: button2.checked
      Layout.fillHeight: true
    }


  }

}
