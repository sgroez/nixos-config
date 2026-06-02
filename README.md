# nixos-config
Nixos config repository for all configurations currently in use by me.

## Setup
1. boot device from manual nixos installer
2. change keyboard layout to de (german layout)
```
loadkeys de
```
3. plug in ethernet or connect to wifi
```
nmcli device wifi connect <SSID> password <PASSWORD>
```
4. clone this repo
5. format the disk using disko
```
sudo nix --experimental-features "nix-command flakes" run \
github:nix-community/disko/latest -- --mode destroy,format,mount <PATH-TO-DISKO-CONFIG>
```
6. install nixos
```
nixos-install --flake .#<CONFIG-NAME>
```

## Config specific setup
### Stateless
7. Create /etc/Yubico/u2f_keys in /nix/persist following (https://nixos.wiki/wiki/Yubikey)
8. Create /stateless/books and /stateless/code in /nix/persist
(make sure these directories are owned by the user)
9. setup .gitconfig and .ssh for github ssh auth following
(https://medium.com/@yourfuse/git-authentication-with-ssh-keys-the-fun-way-edd8fb15d023)
