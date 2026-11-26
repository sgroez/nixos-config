import Quickshell.Io

JsonObject {
  property bool hasNotch: false
  property Fonts fonts: Fonts {}
  property Colors colors: Colors {}

  component Fonts: JsonObject {
    property Font text: Font {
      family: "Sans Serif"
      style: "Regular"
      pixelSize: 10
    }
    property Font icon: Font {
      family: "Sans Serif"
      style: "Regular"
      pixelSize: 10
    }
  }

  component Colors: JsonObject {
    property Color main: Color {
      hex: "#000000"
    }
    property Color darkAccent: Color {
      hex: "#000000"
    }
    property Color brightAccent: Color {
      hex: "#000000"
    }
  }

  //Type templates
  component Font: JsonObject {
    property string family: "Sans Serif"
    property string style: "Regular"
    property real pixelSize: 10
  }

  component Color: JsonObject {
    property string hex: "FFFFFF"
  }
}
