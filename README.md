# nixos-config
Modular NixOS configuration for easy setup

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

## how to build sdimage
to build pi sdimage run:
```
nix build .#nixosConfigurations.piImage.config.system.build.sdImage
```

## how to write to external storage (sd-card)
1\. make sure you know what the device path is using the following command searching for the device with matching capacity and format of the medium you want to use or check which device appears on connecting
```
lsblk
```
    
### how to write sdimage to sd card without zst decompression
2\. change the following command of=/dev/sdX to match your device path and run the command
```
sudo dd if=./result/sd-image/nixos-image-sd-card-*.img of=/dev/sdX bs=4M status=progress conv=fsync
```
