# /etc/nixos/src/share/overlays.nix

{ pkgs, inputs, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    # overlays = [
    #   (final: prev: {
    #     sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: {
    #       postPatch = (old.postPatch or "") + ''
    #         echo ">>> Applying fullscreen-as-maximize sed replacements to sway-unwrapped..."
    #         find . -type f -name "*.c" -exec sed -i \
    #           -e 's/wlr_xdg_toplevel_set_fullscreen/wlr_xdg_toplevel_set_maximized/g' \
    #           -e 's/wlr_xwayland_surface_set_fullscreen/wlr_xwayland_surface_set_maximized/g' \
    #           {} +
    #         echo ">>> Done."
    #       '';
    #     });
    #   })
    # ];
  };
}
