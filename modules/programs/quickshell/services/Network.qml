pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Networking

Singleton {
  id: root

  readonly property var devices: Networking.devices.values

  //wired
  readonly property var wiredDevice: devices.find(d => d.type === DeviceType.Wired) ?? null
  readonly property bool hasWiredConnection: wiredDevice?.connected ?? false

  //wifi
  readonly property var wifiDevice: devices.find(d => d.type === DeviceType.Wifi) ?? null
  readonly property bool hasWifiConnection: wifiDevice?.connected ?? false
  readonly property var networks: wifiDevice?.networks.values ?? []
  readonly property var activeNetwork: networks.find(n => n.connected) ?? null
}
