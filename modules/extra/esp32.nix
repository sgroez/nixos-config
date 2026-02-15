{
  services.udev.extraRules = ''
    KERNEL=="ttyUSB0", MODE:="666"
  '';
}
