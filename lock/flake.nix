{
  inputs = {
    jnumpy.url = "github:Suzhou-Tongyuan/jnumpy";
    jnumpy.flake = false;

    vast2nix.url = "github:gtrunsec/vast2nix";

    diagram2nix.url = "github:gtrunsec/diagram2nix";
  };

  outputs = {self, ...}: {};
}
