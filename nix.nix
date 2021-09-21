{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super:
      {
        nixUnstable = super.nixUnstable.override {
          patches = [ ./unset-is-mach0.patch ];
        };
      }
    )
  ];
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
  };
}
