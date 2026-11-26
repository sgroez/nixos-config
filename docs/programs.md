
# Programs module draft and documentation

## Requirements
- expose options to configure design (font, colors, etc.)

## Draft for configuration api
fontType = {
  family = string;
  weight = string;
  size = int;
};

colorpaletteType = {
  main = string;
  secondary = string;
  background = string;
};

options = {
  font = fontType;
  colors = colorpalletteType;
};

## Draft for computing
take and store design options so that submodules of programs can access them and use them inside configFile string
