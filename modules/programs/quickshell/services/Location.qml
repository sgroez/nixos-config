pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property real lat
  property real lon
  property string city

  Timer {
    interval: 600000 //update every ten minutes
    running: true
    repeat: true
    onTriggered: locationProc.running = true
  }

  Process {
    id: locationProc
    command: ["curl", "ipinfo.io/json"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const locationObj = JSON.parse(text);
        [root.lat, root.lon] = locationObj.loc.split(",").map(parseFloat);
        root.city = locationObj.city;
      }
    }
  }
}
