{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
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
}
