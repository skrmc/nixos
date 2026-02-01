{
  pkgs,
  user,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    docker-compose
    # virt-manager
    quickemu
    qemu
  ];

  users.users.${user}.extraGroups = [
    # "libvirtd"
    "kvm"
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
    # libvirtd = {
    #   enable = true;
    #   qemu = {
    #     package = pkgs.qemu_kvm;
    #     swtpm.enable = true;
    #     ovmf = {
    #       enable = true;
    #       packages = [
    #         (pkgs.OVMF.override {
    #           secureBoot = true;
    #           tpmSupport = true;
    #         }).fd
    #       ];
    #     };
    #   };
    # };
  };
}
