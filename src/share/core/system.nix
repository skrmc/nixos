{ lib, ... }:
{
  boot = {
    loader = {
      timeout = lib.mkDefault 0;
      systemd-boot.enable = true;
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
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    fwupd.enable = true;
  };

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
    };
  };
}
