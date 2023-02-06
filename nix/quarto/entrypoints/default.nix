{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;

  l = inputs.nixpkgs.lib // builtins;
in {
  default = cell.lib.mkQuarto {
    python = ps:
      with ps; [
        # add your custom Python packages here
        pandas
        matplotlib
      ];
    r = rs:
      with rs; [
        # add your custom R packages here
        # ggplot2
        # dplyr
        # ggplot2
        # lubridate
        # readr
        # ggrepel
        # tidyr
      ];

    runtimeInputs = with nixpkgs; [];
    text = ''
      # write your custom bash script here
      quarto "$@"
    '';
  };

  orgToQuarto = writeShellApplication {
    name = "orgToQuarto";
    runtimeInputs = with nixpkgs; [
      sd
    ];
    text = ''
      # write your custom bash script here
      dir="$PRJ_ROOT/docs/"

      path=("$@")
      # shellcheck disable=SC2128
      file="$(basename "$path")"
      cp "$@" "$dir"/"''${file%.md}".qmd
      sd './attach' "$PRJ_ROOT/docs/publish/static/ox-hugo" "$dir""''${file%.md}".qmd
      sd '```julia\n\#\|' '```{julia}\n#|' "$dir""''${file%.md}".qmd
      sd '```ojs\n//\|' '```{ojs}\n//|' "$dir""''${file%.md}".qmd

      ${l.getExe inputs.cells.kernels.packages.jupyenvEval.config.quatroEnv} render "$dir""''${file%.md}".qmd --to html --no-execute-daemon
    '';
  };
  mkQuarto = writeShellApplication {
    name = "mkQuarto";
    runtimeInputs = [inputs.cells.julia.packages.julia-wrapped];
    text = ''
      julia -e 'println("initializing")'

      ${l.getExe cell.entrypoints.orgToQuarto} "$PRJ_ROOT"/docs/publish/content/posts/julia-graph.md
      # ${l.getExe cell.entrypoints.orgToQuarto} "$PRJ_ROOT"/docs/publish/content/posts/observablehq.md
    '';
  };
}
