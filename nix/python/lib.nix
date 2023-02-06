{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells.common.lib) __inputs__;
in {
  poetryArgs = import ./packages/poetryArgs.nix args;

  nixpkgs = import inputs.nixpkgs.path {
    config.allowUnfree = true;
    inherit (inputs.nixpkgs) system;
    overlays = [
      __inputs__.poetry2nix.overlay
      __inputs__.nixpkgs-hardenedlinux.python.overlays.default
      __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.default
    ];
  };
}
