{
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  inputs = {
    main.url = "../.";
    nixpkgs.follows = "main/nixpkgs";
  };

  inputs = {
    jnumpy.url = "github:Suzhou-Tongyuan/jnumpy";
    jnumpy.flake = false;

    vast2nix.url = "github:gtrunsec/vast2nix";
  };

  outputs = {self, ...}: {};
}
