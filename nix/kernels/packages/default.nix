{
  inputs,
  cell,
}: let
  inherit (inputs.jupyenv.lib.x86_64-linux) mkJupyterlabNew mkJupyterlabEval;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
  module = {
    imports = [
      (import ./jupyenv.nix {inherit inputs cell;})
      (import ./modules/quarto.nix {inherit inputs cell;})
      ({
        kernel.bash.data-science.runtimePackages  = [nixpkgs.hello];
      })
    ];
  };
in {
  jupyenv = mkJupyterlabNew module;
  jupyenvEval = mkJupyterlabEval module;
}
