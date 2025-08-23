# nixos-config
Modular NixOS configuration for easy setup

## how to configure flake
to configure the flake to install on your system go through TODOs in the sharedConfig and adjust for your use

## how to create network connction file
copy the following config template into your networkname.nmconnection file
then change id, ssid to your wifi name and psk to your wifi password
```
[connection]
id=MyWiFi
type=wifi
autoconnect=true

[wifi]
ssid=MyWiFiNetwork
mode=infrastructure

[wifi-security]
key-mgmt=wpa-psk
psk=MySecretPassword

[ipv4]
method=auto

[ipv6]
method=auto
```

## how to create ssh key for ssh authentication
```
ssh-keygen -t ed25519
```

## how to build sdimage and iso
to build pi sdimage run:
```
nix build .#nixosConfigurations.piImage.config.system.build.sdImage
```

to build x86 iso run:
```
nix build .#nixosConfigurations.x86Iso.config.system.build.isoImage
```

## how to write to external storage (sd or usb)
1\. make sure you know what the device path is using the following command searching for the device with matching capacity and format of the medium you want to use or check which device appears on connecting
```
lsblk
```
    
### how to write sdimage to sd card with zst decompression
2a. change the following command of=/dev/sdX to match your device path and run the command
```
zstd -d --stdout ./result/sd-image/nixos-image-sd-card-*.img.zst | sudo dd of=/dev/sdX bs=4M status=progress conv=fsync
```

### how to write iso to usb drive
2b. change the following command of=/dev/sdX to match your device path and run the command
```
dd if=./result/iso/nixos-minimal-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

###TODO add how to remote deploy with password encrypted ssh private key file

###TODO add modules to configurations
