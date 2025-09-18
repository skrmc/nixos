# /etc/nixos/src/share/overlays.nix

{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = inputs.hyprland.packages.${final.system}.hyprland;
      xdg-desktop-portal-hyprland = inputs.hyprland.packages.${final.system}.xdg-desktop-portal-hyprland;
      hyprlandPlugins.hyprexpo = inputs.hyprland-plugins.packages.${final.system}.hyprexpo;
    })

    (final: prev: {
      sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          echo ">>> Applying fullscreen-as-maximize sed replacements to sway-unwrapped..."
          find . -type f -name "*.c" -exec sed -i \
            -e 's/wlr_xdg_toplevel_set_fullscreen/wlr_xdg_toplevel_set_maximized/g' \
            -e 's/wlr_xwayland_surface_set_fullscreen/wlr_xwayland_surface_set_maximized/g' \
            {} +
          echo ">>> Done."
        '';
      });
    })
  ];
}
