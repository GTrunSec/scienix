{
  inputs = {
    jnumpy.url = "github:Suzhou-Tongyuan/jnumpy";
    jnumpy.flake = false;

    vast2nix.url = "github:gtrunsec/vast2nix";

    diagram2nix.url = "github:gtrunsec/diagram2nix";

    poetry2nix.url = "github:nix-community/poetry2nix";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
  };

  outputs = {self, ...}: {};
}
