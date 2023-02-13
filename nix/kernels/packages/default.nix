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
    ];
  };
in {
  jupyenv = mkJupyterlabNew module;
  jupyenvEval = mkJupyterlabEval module;

  allKernelsPath = let
    syncKernels = l.concatMapStringsSep "\n" (p: ''
      rsync --chmod +rw -avzh ${p}/kernels/${p.kernelInstance.name}/* \
      $out/.local/share/jupyter/kernels/${p.kernelInstance.language}
    '') (l.attrValues inputs.cells.kernels.packages.jupyenv.passthru.kernels);
  in
    nixpkgs.runCommand "allKernelsPath" {
      name = "allKernelsPath";
      buildInputs = [nixpkgs.rsync];
    } ''
      mkdir -p $out/.local/share/jupyter/kernels
      ${syncKernels}
    '';
}
