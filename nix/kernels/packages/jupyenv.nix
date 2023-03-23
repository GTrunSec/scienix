{
  inputs,
  cell,
}: {
  pkgs,
  config,
  lib,
  ...
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [
    inputs.julia2nix.overlays.default
  ];
in {
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
        extraPackages = ps: ([
            ps.python-lsp-server
            ps.jupytext
          ]
          ++ ps.python-lsp-server.passthru.optional-dependencies.all);
      };
    };
    kernel.python.data-science = {
      enable = true;
      poetryEnv = inputs.cells.python.lib.mkPoetryEnv {};
      # ignoreCollisions = true;
    };
    kernel.julia.data-science = {
      enable = true;
      julia = inputs.cells.julia.packages.julia-wrapped;
    };
    kernel.haskell.data-science = {
      enable = true;
    };
    kernel.bash.data-science = {
      runtimePackages = [];
      enable = true;
    };
    publishers.quarto = {
      enable = true;
    };
  };
}
