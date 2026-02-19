{
  pkgs,
  user,
  ...
}:
{
  home-manager.users.${user} = {
    stylix.targets.fcitx5.enable = true;

    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
          fcitx5-pinyin-moegirl
          fcitx5-pinyin-zhwiki
        ];
        # ignoreUserConfig = true;
        settings = {
          addons = {
            pinyin.globalSection = {
              CloudPinyinEnabled = "True";
              CloudPinyinIndex = 2;
            };
            cloudpinyin.globalSection = {
              Backend = "Google";
            };
          };
          globalOptions = {
            "Hotkey/TriggerKeys" = {
              "0" = "Super+space";
            };
          };
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              "Name" = "Default";
              "Default Layout" = "us";
              "DefaultIM" = "keyboard-us";
            };
            "Groups/0/Items/0"."Name" = "keyboard-us";
            "Groups/0/Items/1"."Name" = "pinyin";
          };
        };
      };
    };
  };

  fonts.packages = with pkgs; [
    lxgw-wenkai
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
