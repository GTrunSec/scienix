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
      extensions = {
        features = ["lsp" "jupytext"];
        languageServers = {
          python = ps: ps.python-lsp-server;
          haskell = nixpkgs.haskellPackages.ghcWithPackages (ghcPkgs:
            with ghcPkgs; [
              haskell-language-server
              hlint
              cabal-install
              alex
              happy
              # stack
            ]);
        };
      };
      notebookConfig = {
        ServerApp.root_dir = "./modules/playground";
        ServerApp.notebook_dir = "./modules/playground";
        ServerApp.contents_manager_class = "jupytext.TextFileContentsManager";
        ContentsManager.notebook_extensions = "ipynb,Rmd,jl,md,py,hs";
        LanguageServerManager.language_servers.haskell-language-server = {
          serverSettings =
            lib.importJSON ./hls.json;
          "haskell.plugin.ghcide-completions.globalOn" = true;
          "haskell.plugin.ghcide-completions.config.autoExtendOn" = true;
          "haskell.plugin.ghcide-completions.config.snippetsOn" = true;
          "haskell.formattingProvider" = "ormolu";
        };
        runtimePackages = [];
      };
      jupyterlabEnvArgs.extraPackages = ps: ([] ++ ps.python-lsp-server.passthru.optional-dependencies.all);
    };
    kernel.python.data-science =
      (inputs.cells.python.lib.poetryArgs {
        jupyenv = true;
      })
      // {
        enable = true;
      };
    kernel.julia.data-science = {
      enable = true;
      julia = inputs.cells.julia.packages.julia-wrapped;
    };
    kernel.haskell.data-science = {
      enable = true;
    };
    kernel.nix.data-science = {
      enable = true;
    };
    kernel.bash.data-science = {
      enable = true;
    };
    publishers.quarto = {
      enable = true;
    };
  };
}
