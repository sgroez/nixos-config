pragma Singleton

import Quickshell

Singleton {
  id: root

  readonly property var weatherIcons: ({
    "113": "clear_day",
    "116": "partly_cloudy_day",
    "119": "cloud",
    "122": "cloud",
    "143": "foggy",
    "176": "rainy",
    "179": "rainy",
    "182": "rainy",
    "185": "rainy",
    "200": "thunderstorm",
    "227": "cloudy_snowing",
    "230": "snowing_heavy",
    "248": "foggy",
    "260": "foggy",
    "263": "rainy",
    "266": "rainy",
    "281": "rainy",
    "284": "rainy",
    "293": "rainy",
    "296": "rainy",
    "299": "rainy",
    "302": "weather_hail",
    "305": "rainy",
    "308": "weather_hail",
    "311": "rainy",
    "314": "rainy",
    "317": "rainy",
    "320": "cloudy_snowing",
    "323": "cloudy_snowing",
    "326": "cloudy_snowing",
    "329": "snowing_heavy",
    "332": "snowing_heavy",
    "335": "snowing",
    "338": "snowing_heavy",
    "350": "rainy",
    "353": "rainy",
    "356": "rainy",
    "359": "weather_hail",
    "362": "rainy",
    "365": "rainy",
    "368": "cloudy_snowing",
    "371": "snowing",
    "374": "rainy",
    "377": "rainy",
    "386": "thunderstorm",
    "389": "thunderstorm",
    "392": "thunderstorm",
    "395": "snowing"
  })

  readonly property var batteryIcons: ({
    90: "battery_android_full",
    70: "battery_android_5",
    50: "battery_android_4",
    30: "battery_android_3",
    20: "battery_android_2",
    10: "battery_android_1",
    0:  "battery_android_alert",
  })

  function getWeatherIcon(code: string): string {
    if (weatherIcons.hasOwnProperty(code))
      return weatherIcons[code];
    return "air";
  }

  function getBatteryIcon(batteryDevice) {
    const batteryLevel = batteryDevice.percentage * 100;
    const levels = Object.keys(batteryIcons)
      .map(Number)
      .sort((a, b) => b - a); // Descending sort

    for (let level of levels) {
      if (batteryLevel >= level) {
        return batteryIcons[level];
      }
    }

    return undefined; // If below all thresholds
  }

  function getWifiIcon(connection) {
    if (connection != null) {
      if (connection.signalStrength < 0.33) {
        return "wifi_1_bar"
      }else if (connection.signalStrength < 0.66) {
        return "wifi_2_bar"
      }else {
        return "wifi"
      }
    }
    return "wifi_off"
  }
}
