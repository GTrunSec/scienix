{
  inputs,
  cell,
}: let
  inherit (inputs.std-ext.writers.lib) writeShellApplication writeComoniconApplication;
  inherit (inputs) self nixpkgs std;
in {
  podman = writeShellApplication {
    name = "podman";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      nix run .\#tullia.${nixpkgs.system}.task.julia.oci.image.copyToPodman
      podman run -it "$(nix eval --raw .\#tullia.x86_64-linux.task.julia.oci.image.imageName):$(nix eval --raw .\#tullia.x86_64-linux.task.julia.oci.image.imageTag)"
    '';
  };
  jnumpy-podman = writeShellApplication {
    name = "jnumpy-podman";
    runtimeInputs = [nixpkgs.podman];
    text = ''
      nix run .\#tullia.${nixpkgs.system}.task.jnumpy.oci.image.copyToPodman
      podman run -v "$(pwd):/repo" -it "$(nix eval --raw .\#tullia.x86_64-linux.task.jnumpy.oci.image.imageName):$(nix eval --raw .\#tullia.x86_64-linux.task.jnumpy.oci.image.imageTag)"
    '';
  };
  cli = let
    mkJulia = inputs.julia2nix.julia2nix.lib.buildEnv {
      name = "mkJulia";
      src = ./cli;
      package = inputs.std-ext.comonicon.packages.julia-wrapped;
    };
  in
    writeComoniconApplication {
      name = "cli";
      julia = {
        package = mkJulia;
        pure = true;
      };
      runtimeEnv = {
        b = "1";
      };
      runtimeInputs = [];
      path = ./cli;
      args = ["mycli.jl"];
    };
}
