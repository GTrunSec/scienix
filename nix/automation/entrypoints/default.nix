{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  inherit (inputs) self nixpkgs std;

  org =
    nixpkgs.runCommand "graphite_local_settings" {
      org = "${(std.incl self ["docs"])}/docs/org";
      buildInputs = [nixpkgs.ripgrep];
      preferLocalBuild = true;
    } ''
      cp -rf --no-preserve=mode,ownership $org $out
      for file in $(rg -l -- "ein-" $out); do
        substituteInPlace $file \
        --replace "#+begin_src ein-" "#+begin_src "
        done
    '';
in {
  mkdoc = let
    org-roam-book = inputs.cells-lab.inputs.org-roam-book-template.packages.${nixpkgs.system}.default.override {
      inherit org;
    };
  in
    writeShellApplication {
      name = "mkdoc";
      runtimeInputs = [nixpkgs.hugo];
      text = ''
        rsync -avzh ${org-roam-book}/* docs/publish
        cd docs/publish && cp ../config.toml .
        hugo "$@"
        cp -rf --no-preserve=mode,ownership public/posts/index.html ./public/
      '';
    };
}
