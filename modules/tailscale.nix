{ config, pkgs, lib, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixos-unstable)
    { config = config.nixpkgs.config; };
in
{

# Enable tailscale
  services.tailscale = {
    enable = true;
    port = 41641;
    package = unstable.tailscale;
  };

}
