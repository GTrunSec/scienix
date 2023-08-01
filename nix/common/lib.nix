{ inputs, cell }:
let
  inherit (inputs) nixpkgs flops;

  callMainFlake =
    (flops.lib.flake.pops.default.setInitInputs inputs.self).setSystem
      nixpkgs.system;

  callFlake =
    (flops.lib.flake.pops.default.setInitInputs ./lib/lock).setSystem
      nixpkgs.system;
in
{
  inherit callFlake;
  __inputs__ = callFlake.outputsForInputs;
  # nixpkgs = inputs.nixpkgs.appendOverlays [
  #   __inputs__.poetry2nix.overlay
  #   __inputs__.nixpkgs-hardenedlinux.python.overlays.default
  #   __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.default
  # ];
}
