{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  inherit (cell.packages) jupyterEnvironment;
in {
  linkKernels = let
    cpKernel = n: ''
      cp -r ${jupyterEnvironment.passthru.kernels."${n}-jupyter-kernel"}/kernels/${n} \
      "$HOME"/.local/share/jupyter/kernels/${n}
    '';
  in
    writeShellApplication {
      name = "link-kernels";
      runtimeInputs = [];
      text = ''
        if [ ! -d "$HOME"/.local/share/jupyter/kernels ]; then
          mkdir -p "$HOME"/.local/share/jupyter/kernels
        fi
        ${cpKernel "julia"}
        ${cpKernel "python"}
        ${cpKernel "bash"}
      '';
    };
}
