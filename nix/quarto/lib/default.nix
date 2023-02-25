{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;

  l = inputs.nixpkgs.lib // builtins;
in {
  mkQuarto = import ./mkQuarto.nix args;

  orgToQuarto = jupyerEval: writeShellApplication {
    name = "orgToQuarto";
    runtimeInputs = with nixpkgs; [
      sd
    ];
    text = ''
      # write your custom bash script here
      dir="$PRJ_ROOT/docs/quarto/"

      # shellcheck disable=SC2044
      for file in $(find "$@" -type f -name "*.md"); do
        # shellcheck disable=SC2128
        file_name="$(basename "$file")"
        cp "$file" "$dir"/"''${file_name%.md}".qmd
        sd './attach' "$PRJ_ROOT/docs/publish/static/ox-hugo" "$dir""''${file_name%.md}".qmd
        sd '```julia\n\#\|' '```{julia}\n#|' "$dir""''${file_name%.md}".qmd
        sd '```bash\n\#\|' '```{bash}\n#|' "$dir""''${file_name%.md}".qmd
        sd '```ojs\n//\|' '```{ojs}\n//|' "$dir""''${file_name%.md}".qmd
      done
      ${l.getExe jupyerEval.config.quartoEnv} render "$dir" --to html --no-execute-daemon
    '';
  };
}
