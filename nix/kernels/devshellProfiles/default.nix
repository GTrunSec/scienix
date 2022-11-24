{
  inputs,
  cell,
}: {
  default = {
    commands = [
      {
        name = "jupyterlab";
        command = ''
          set +u
          jupyterEnv lab --ip $1 --port $2 --config $PRJ_ROOT/conf/jupyter_notebook_config.py
        '';
        help = "jupyterlab <IP> <PORT> <juliaPackageDir> | Example: jupyterlab 10.220.170.112 8888";
      }
      {
        name = "jupyterEnv";
        command = "${inputs.cells.kernels.packages.jupyterEnvironment}/bin/jupyter $@";
        help = "exec jupyter in the jupyterLab environment";
      }
    ];
  };
}
