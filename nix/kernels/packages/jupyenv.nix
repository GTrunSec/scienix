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
    inputs.haskell-language-server.overlays.default
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
          haskell = nixpkgs.haskell.packages.ghc925.ghcWithPackages (ghcPkgs:
            with ghcPkgs; [
              inputs.haskell-language-server.packages.haskell-language-server-925
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
        ContentsManager.notebook_extensions = "ipynb,Rmd,jl,md,py";
        # LanguageServerManager.language_servers.haskell-language-server.workspace_configuration = {
        #   "haskell.plugin.ghcide-completions.globalOn" = true;
        #   "haskell.plugin.ghcide-completions.config.autoExtendOn" = true;
        #   "haskell.plugin.ghcide-completions.config.snippetsOn" = true;
        #   "haskell.formattingProvider" = "ormolu";
        # };
      };
      runtimePackages = [];
      jupyterlabEnvArgs.extraPackages = ps: ([] ++ ps.python-lsp-server.passthru.optional-dependencies.all);
    };
    kernel.python.data-science =
      (inputs.cells.python.lib.poetryAttrs {
        jupyenv = true;
      })
      // {
        enable = true;
      };
    kernel.julia.data-science = {
      enable = true;
      julia = pkgs.lib.julia-wrapped {};
    };
    kernel.haskell.data-science = {
      enable = true;
    };
    kernel.bash.data-science = {
      enable = true;
    };
  };
}
