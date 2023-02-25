{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;

  l = inputs.nixpkgs.lib // builtins;
in {
  default = cell.lib.mkQuarto {
    runtimeInputs = with nixpkgs; [];
    text = ''
      # write your custom bash script here
      quarto "$@"
    '';
  };

  mkQuarto = writeShellApplication {
    name = "mkQuarto";
    runtimeInputs = [inputs.cells.julia.packages.julia-wrapped];
    text = ''
      julia -e 'println("initializing")'

      ${l.getExe (cell.lib.orgToQuarto inputs.cells.kernels.packages.jupyenvEval)} "$PRJ_ROOT"/docs/publish/content/posts
    '';
  };
}
