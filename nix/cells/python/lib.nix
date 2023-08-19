{ inputs, cell }:
{
  mkPoetryEnv = import ./packages/mkPoetryEnv.nix { inherit inputs cell; };

  nixpkgs = import inputs.nixpkgs.path {
    config.allowUnfree = true;
    inherit (inputs.nixpkgs) system;
    overlays = [
      inputs.poetry2nix.overlay
      inputs.nixpkgs-hardenedlinux.pkgs.overlays.python
      inputs.nixpkgs-hardenedlinux.pkgs.overlays.default
    ];
  };
}
