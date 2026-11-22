import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config

PanelWindow {
  id: root
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 33
  color: "transparent"

  RowLayout {
    id: content
    anchors.fill: parent
    anchors.margins: 15
    anchors.leftMargin: 50
    anchors.rightMargin: 50

    //Left
    RowLayout {
      id: left
      spacing: 20
      Layout.fillWidth: true

      Clock {}
      Calendar {}
    }

    //Spacer
    Item {
      Layout.fillWidth: true
    }

    //Middle
    RowLayout {
      id: middle
      spacing: 10
      Layout.fillWidth: true
      visible: Config.appearance.hasNotch === false

      WeatherIndicator {}
    }

    //Spacer
    Item {
      Layout.fillWidth: true
    }

    //Right
    RowLayout {
      id: right
      spacing: 10
      Layout.fillWidth: true

      BluetoothIndicator {}
      WifiIndicator {}
      Battery {}
    }
  }
}
