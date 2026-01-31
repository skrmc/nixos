{ lib, ... }:

{
  boot = {
    loader = {
      timeout = lib.mkDefault 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # lanzaboote = {
    #   enable = true;
    #   pkiBundle = "/var/lib/sbctl";
    # };
    kernelParams = lib.mkDefault [ "consoleblank=300" ];
    supportedFilesystems = lib.mkDefault [ "ntfs" ];
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  zramSwap.enable = true;
  swapDevices = lib.mkForce [ ];

  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.sessionVariables.NIX_PAGER = "cat";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 1073741824; # 1GB
  };

  system.stateVersion = "25.05";
}
