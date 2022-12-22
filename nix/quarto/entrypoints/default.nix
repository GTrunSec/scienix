{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
in {
  example = cell.lib.mkEnv {
    python = ps:
      with ps; [
        # add your custom Python packages here
        pandas
        matplotlib
      ];
    runtimeInputs = with nixpkgs; [sd];
    text = ''
      # write your custom bash script here
      dir="$PRJ_ROOT/docs/"

      path=("$@")
      # shellcheck disable=SC2128
      file="$(basename "$path")"
      cp "$@" "$dir"/"''${file%.md}".qmd
      sd './attach' "$PRJ_ROOT/docs/publish/static/ox-hugo" "$dir""''${file%.md}".qmd
      sd '```julia\n\#\|' '```{julia}\n#|' "$dir""''${file%.md}".qmd

      quarto render  "$dir""''${file%.md}".qmd --to html
    '';
  };
}
