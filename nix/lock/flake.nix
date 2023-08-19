{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/6ccc4a59c3f1b56d039d93da52696633e641bc71";

    jnumpy.url = "github:Suzhou-Tongyuan/jnumpy";
    jnumpy.flake = false;

    diagram2nix.url = "github:gtrunsec/diagram2nix";
    diagram2nix.inputs.nixpkgs.follows = "nixpkgs";

    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";

    matrix-attack-data.url = "github:GTrunSec/matrix-attack-data";
    matrix-attack-data.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = _: {};
}
