{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
in {
  mkAutoCommit = path: branch:
    writeShellApplication {
      name = "mkAutoCommit";
      runtimeInputs = [inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.packages.gptcommit];
      text = ''
        gptcommit install
        cd "$PRJ_ROOT"/modules/${path}
        treefmt .
        git add .
        git commit --no-edit
        git push ${branch} --no-verify
        gptcommit uninstall
      '';
    };

  orgToHugo = src: let
    patchedOrg =
      nixpkgs.runCommand "patchOrg" {
        org = src;
        buildInputs = [nixpkgs.ripgrep];
        preferLocalBuild = true;
      } ''

        cp -rf --no-preserve=mode,ownership $org $out
        for file in $(rg -l -- "begin_src jupyter-" $out); do
          substituteInPlace $file \
          --replace "#+begin_src jupyter-" "#+begin_src "
          done
      '';
    org-roam-book =  inputs.cells-lab.inputs.org-roam-book-template.packages.${nixpkgs.system}.default.override {
      org = patchedOrg;
    };
  in
    writeShellApplication {
      name = "mkdoc";
      runtimeInputs = [nixpkgs.hugo];
      text = ''
      rsync --chmod +rw -avzh ${org-roam-book}/* docs/publish
      cd docs/publish && cp ../config.toml .
      hugo "$@"
      cp -rfp --no-preserve=mode,ownership public/posts/index.html ./public/
    '';
    };
}
