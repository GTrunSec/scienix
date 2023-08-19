{ inputs, cell }:
{
  default = {
    commands = [
      {
        name = "jupyenv";
        command = ''
          nix run $PRJ_ROOT#x86_64-linux.kernels.packages.jupyenv -- --ip $1 --port $2
        '';
        help = "jupyterlab <IP> <PORT> <juliaPackageDir> | Example: jupyterlab 10.220.170.112 8888";
      }
      {
        command = ''
          2>/dev/null ${inputs.cells.jupyter.packages.jupyenv}/bin/jupyter "$@"
        '';
        name = "jupyter";
        help = "The executable jupyter of Jupyenv";
      }
    ];
  };
}
