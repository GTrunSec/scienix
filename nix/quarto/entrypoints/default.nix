{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;

  l = inputs.nixpkgs.lib // builtins;
in {
  default = cell.lib.mkEnv {
    python = ps:
      with ps; [
        # add your custom Python packages here
        pandas
        matplotlib
      ];
    runtimeInputs = with nixpkgs; [];
    text = ''
      # write your custom bash script here
      quarto render "$@"
    '';
  };

  orgToQuarto = writeShellApplication  {
    name = "orgToQuarto";
    runtimeInputs = with nixpkgs;[cell.entrypoints.default sd];
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

      quarto render "$dir""''${file%.md}".qmd --to html
      '';
  };
  mkQuarto = writeShellApplication {
    name = "mkQuarto";
    runtimeInputs = [inputs.cells.julia.packages.julia-wrapped];
    text = ''
      julia -e 'println("initializing")'

      ${l.getExe inputs.cells.kernels.entrypoints.linkKernels}
      ${l.getExe cell.entrypoints.orgToQuarto} "$PRJ_ROOT"/docs/publish/content/posts/julia-graph.md
      # ${l.getExe cell.entrypoints.orgToQuarto} "$PRJ_ROOT"/docs/publish/content/posts/observablehq.md
    '';
  };
}
