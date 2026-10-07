{
  services = {
    resolved.enable = true;
    tailscale.enable = true;
  };

  networking = {
    useDHCP = true;
    useNetworkd = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
    wireless.iwd.enable = true;
  };

  systemd.network = {
    enable = true;
    wait-online = {
      enable = true;
      anyInterface = true;
    };
  };
}
