{
  imports = [
    ./auth/pam.nix
    ./profiles/base.nix
    ./profiles/gui.nix
    ./profiles/multimedia.nix
    ./profiles/coding.nix
    ./profiles/gaming.nix
    ./programs
    ./stateless/impermanence.nix
    ./extra/bluetooth.nix
    ./extra/javelinkeyboard.nix
    ./extra/huaweiusbmodem.nix
    ./extra/powermanagement.nix
    ./extra/sharenetwork.nix
  ];
}
