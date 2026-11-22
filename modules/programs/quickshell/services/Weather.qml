pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property real maxTemp
  property real minTemp
  property real temp
  property int code

  Timer {
    interval: 600000 //update every ten minutes
    running: true
    repeat: true
    onTriggered: weatherProc.running = true
  }

  Process {
    id: weatherProc
    command: ["curl", `v2.wttr.in/${Location.city}?format=j1`]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const weatherObj = JSON.parse(text)
        root.maxTemp = weatherObj.weather[0].maxtempC;
        root.minTemp = weatherObj.weather[0].mintempC;
        root.temp = weatherObj.current_condition[0].temp_C;
        root.code = weatherObj.current_condition[0].weatherCode;
      }
    }
  }
}
