import Quickshell
import Quickshell.Services.UPower
import QtQuick
import qs.components
import qs.utils
import qs.config

Item {
  id: root
  implicitWidth: battery.width
  implicitHeight: battery.height

  Icon {
    id: battery
    text: Icons.getBatteryIcon(UPower.displayDevice)
    anchors.centerIn: parent
    z: 0
  }
  Icon {
    text: UPower.onBattery ? "" : "bolt"
    color: Config.appearance.colors.brightAccent.hex
    anchors.centerIn: parent
    z: 1
  }
}
