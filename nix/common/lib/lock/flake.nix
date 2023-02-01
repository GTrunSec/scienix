{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/bb31220cca6d044baa6dc2715b07497a2a7c4bc7";

    jnumpy.url = "github:Suzhou-Tongyuan/jnumpy";
    jnumpy.flake = false;

    vast2nix.url = "github:gtrunsec/vast2nix";

    diagram2nix.url = "github:gtrunsec/diagram2nix";
    diagram2nix.inputs.nixpkgs.follows = "nixpkgs";

    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, ...}: {};
}
