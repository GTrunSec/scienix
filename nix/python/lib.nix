{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;
in
{
  mkPoetryEnv = import ./packages/mkPoetryEnv.nix { inherit inputs cell; };

  nixpkgs = import inputs.nixpkgs.path {
    config.allowUnfree = true;
    inherit (inputs.nixpkgs) system;
    overlays = [
      __inputs__.poetry2nix.overlay
      __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.python
      __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.default
    ];
  };
}
