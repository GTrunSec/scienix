{ inputs, cell }:
{
  pkgs,
  config,
  lib,
  ...
}:
let
  nixpkgs = inputs.nixpkgs.appendOverlays [ inputs.julia2nix.overlays.default ];
in
{
  config = {
    inherit nixpkgs;
    jupyterlab = {
      notebookConfig = {
        ServerApp.root_dir = "./modules/playground";
        ServerApp.notebook_dir = "./modules/playground";
        ServerApp.contents_manager_class = "jupytext.TextFileContentsManager";
        ContentsManager.notebook_extensions = "ipynb,Rmd,jl,md,py,hs";
      };
      jupyterlabEnvArgs = {
        extraPackages = ps: [ ps.jupytext ];
      };
    };
    kernel.python.data-science = {
      enable = true;
      env = inputs.cells.python.lib.mkPoetryEnv { groups = [ "jupyenv" ]; };
    };
    kernel.julia.data-science = {
      enable = true;
      julia = inputs.cells.julia.packages.julia-wrapped;
    };
    kernel.bash.data-science = {
      runtimePackages = [ pkgs.d2 ];
      enable = true;
    };
    publishers.quarto = {
      enable = true;
    };
  };
}
