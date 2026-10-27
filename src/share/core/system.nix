{ lib, ... }:
{
  boot = {
    loader = {
      timeout = lib.mkDefault 0;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "consoleblank=60" ];
    supportedFilesystems = [ "ntfs" ];
  };

  time.timeZone = "America/Chicago";
  # time.timeZone = "America/New_York";
  # time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  zramSwap.enable = true;
  swapDevices = lib.mkForce [ ];

  services = {
    openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    fwupd.enable = true;
    earlyoom.enable = true;
    journald.settings.Journal.SystemMaxUse = "500M";
  };

  documentation.man.cache.enable = false;

  environment = {
    localBinInPath = true;
    sessionVariables.NIX_PAGER = "cat";
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 1073741824; # 1GB
      warn-dirty = false;
    };
  };
}
