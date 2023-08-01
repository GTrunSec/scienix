{ inputs, cell }:
let
  inherit (inputs.jupyenv.lib.x86_64-linux) mkJupyterlabNew mkJupyterlabEval;
  inherit (inputs) nixpkgs;
  module = {
    imports = [
      (import ./jupyenv.nix { inherit inputs cell; })
      cell.jupyenvModules.quarto
    ];
  };
in
{
  inherit mkJupyterlabEval;
  jupyenv = mkJupyterlabNew module;
  jupyenvEval = mkJupyterlabEval module;
}
