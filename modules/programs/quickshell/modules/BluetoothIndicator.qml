import Quickshell
import Quickshell.Bluetooth
import QtQuick
import qs.components

Icon {
  id: root
  text: {
    if (Bluetooth.defaultAdapter.enabled) {
      return "bluetooth"
    }
    return "bluetooth_disabled"
  }
}
