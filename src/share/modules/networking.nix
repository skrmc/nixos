{
  services.resolved.enable = true;
  services.tailscale.enable = true;

  networking = {
    useDHCP = true;
    useNetworkd = true;
    # firewall.enable = false;
    wireless.iwd.enable = true;
  };

  systemd.network = {
    enable = true;
    wait-online.enable = true;
  };
}
