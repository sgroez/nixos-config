pragma Singleton

import Quickshell
import Quickshell.Io
import Qt.labs.platform

Singleton {
  id: root

  property alias appearance: adapter.appearance

  FileView {
    path: `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/bar.json`
    watchChanges: true
    onFileChanged: reload()

    JsonAdapter {
      id: adapter

      property Appearance appearance: Appearance {}
    }
  }
}
