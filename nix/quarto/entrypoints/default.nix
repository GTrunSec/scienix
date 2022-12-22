{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
in {
  example = cell.lib.mkEnv {
    r = ps:
      with ps; [
        # add your custom R packages here
        ggplot2
        dplyr
        ggplot2
        lubridate
        readr
        ggrepel
        tidyr
      ];
    python = ps:
      with ps; [
        # add your custom Python packages here
        pandas
        matplotlib
      ];
    runtimeInputs = with nixpkgs; [sd];
    text = ''
      # write your custom bash script here
      file=("$@")
      cp "$@" "''${file%.md}".qmd
      sd './attach' '../../static/ox-hugo' "''${file%.md}".qmd
      sd '```julia\n\#\|' '```{julia}\n#|' "''${file%.md}".qmd

      quarto render "''${file%.md}".qmd --to html --no-clean
    '';
  };
}
