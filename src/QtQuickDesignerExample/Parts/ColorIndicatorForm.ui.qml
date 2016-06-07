import QtQuick 2.4

Item {
  property bool on: false
  implicitHeight: text1.implicitHeight+5
  implicitWidth: text1.implicitWidth+5

    Rectangle {
        id: rectangle1
        radius: 5
        gradient: Gradient {
          GradientStop {
            id: gradientStop1
                position: 0
                color: "#bd0707"
            }

          GradientStop {
            id: gradientStop2
            position: 1
            color: "#000000"
          }
        }
        anchors.fill: parent

        Text {
            id: text1
            x: 130
            y: 79
            color: "#ffffff"
            text: on ? qsTr("ON") : qsTr("OFF")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
    }
    states: [
      State {
        name: "on"

        PropertyChanges {
          target: gradientStop1
          color: "#9498d9"
        }

        PropertyChanges {
          target: gradientStop2
          color: "#0f179e"
            }
      }
    ]
}
