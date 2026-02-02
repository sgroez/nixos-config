{ pkgs, ... }: {
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", KERNELS=="*:9000:400D.*", MODE="0666"
  '';
}
