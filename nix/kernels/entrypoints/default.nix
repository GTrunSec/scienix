{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.std-ext.writers.lib) writeShellApplication;
  inherit (cell.packages) jupyenv;

  l = inputs.nixpkgs.lib // builtins;
in {
  linkKernels = let
    syncKernels = l.concatMapStringsSep "\n" (p: ''
       rsync --chmod +rw -avzh ${p}/kernels/${p.kernelInstance.name}/* \
      "$HOME"/.local/share/jupyter/kernels/${p.kernelInstance.language}
    '') (l.attrValues jupyenv.passthru.kernels);
  in
    writeShellApplication {
      name = "link-kernels";
      runtimeInputs = [nixpkgs.rsync];
      text = ''
         if [ ! -d "$HOME"/.local/share/jupyter/kernels ]; then
           mkdir -p "$HOME"/.local/share/jupyter/kernels
         fi

         ${syncKernels}

        if [ -d "$HOME"/.local/share/jupyter/kernels/julia-1.8 ]; then
             rm -rf "$HOME"/.local/share/jupyter/kernels/julia-1.8
             cp -r "$HOME"/.local/share/jupyter/kernels/julia "$HOME"/.local/share/jupyter/kernels/julia-1.8
        else
           cp -r "$HOME"/.local/share/jupyter/kernels/julia "$HOME"/.local/share/jupyter/kernels/julia-1.8
        fi
      '';
    };
  auto-commit-playground = inputs.cells.automation.lib.mkAutoCommit "playground" "origin HEAD:main";
}
