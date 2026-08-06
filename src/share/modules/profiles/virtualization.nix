{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.profiles.virtualization;
in
{
  options.profiles.virtualization.enable = lib.mkEnableOption "virtualization tools";

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;

    users.users.${user}.extraGroups = [
      "kvm"
      "libvirtd"
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
