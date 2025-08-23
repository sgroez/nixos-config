{
  # Firewall rules for NAT
  networking.firewall.extraCommands = ''
    # Set up SNAT on packets going from downstream to the wider internet
    iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE

    # Accept all connections from downstream. May not be necessary
    iptables -A INPUT -i enp0s31f6 -j ACCEPT
  '';

  networking.nftables.ruleset = ''
  table ip nat {
    chain POSTROUTING {
      type nat hook postrouting priority 100;
      oifname "wlp3s0" counter masquerade
    }
  }
  table ip filter {
    chain INPUT {
      iifname "enp0s31f6" counter accept
    }
  }
'';

  environment.etc."NetworkManager/system-connections/shared-connection.nmconnection" = {
    source = ./shared-connection.nmconnection;
    mode = "0600";
    user = "root";
    group = "root";
  };
}
