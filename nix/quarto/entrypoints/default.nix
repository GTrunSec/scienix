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
      tmp="$PRJ_ROOT/.cache/"
      path=("$@")
      # shellcheck disable=SC2128
      file="$(basename "$path")"
      cp "$@" "$tmp"/"''${file%.md}".qmd
      sd './attach' "$PRJ_ROOT/docs/publish/static/ox-hugo" "$tmp""''${file%.md}".qmd
      sd '```julia\n\#\|' '```{julia}\n#|' "$tmp""''${file%.md}".qmd

      quarto render  "$tmp""''${file%.md}".qmd --to html
    '';
  };
}
