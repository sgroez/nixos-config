# inspired by github.com/plmercereau/nixos-pi-zero-2
{ config, pkgs, ... }: {
  imports = [
    ./sd-image.nix
  ];

  hardware.deviceTree = {
    enable = true;
    kernelPackage = pkgs.linuxKernel.packages.linux_rpi3.kernel;
    filter = "*2837*";
    overlays = [
      { name = "gpio keyboard"; dtsFile = ./dts/gpio-keyboard.dts; }
      {
        name = "spi1-2cs";
        dtsFile = ./dts/spi.dts;
      }
    ];
  };

  sdImage = {
    # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low on space.
    compressImage = false;
    imageName = "zero2.img";

    extraFirmwareConfig = {
      # Give up VRAM for more Free System Memory
      # - Disable camera which automatically reserves 128MB VRAM
      start_x = 0;
      # - Reduce allocation of VRAM to 16MB minimum for non-rotated (32MB for rotated)
      gpu_mem = 16;

      # Configure display to 800x600 so it fits on most screens
      # * See: https://elinux.org/RPi_Configuration
      hdmi_group = 2;
      hdmi_mode = 8;
    };
  };
}
