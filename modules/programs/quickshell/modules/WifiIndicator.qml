import Quickshell
import QtQuick
import qs.components
import qs.services
import qs.utils

Icon {
  id: root
  text: Icons.getWifiIcon(Network.activeNetwork)
}
