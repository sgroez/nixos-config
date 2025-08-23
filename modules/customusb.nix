{ pkgs, ... }: {
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="cafe", ATTR{idProduct}=="4010", MODE="0666"
  '';
}
