{
  inputs,
  cell,
}: let
  inherit (inputs.std-ext.writers.lib) writeShellApplication;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  hello =
    (let
      dockerCompose = {
        services = {
          web = {
            image = "ghcr.io/gtrunsec/desci/hello";
            ports = ["9090:9090"];
            volumes = [".:/work"];
            environment = {
              FLASK_DEBUG = "true";
            };
            stop_signal = "SIGINT";
          };
        };
      };
    in
      writeShellApplication {
        name = "hello-deploy";
        runtimeInputs = [nixpkgs.docker-compose];
        text = ''
          # Bash does not automatically forward signals to subprocesses
          # don't forget to use exec
          # exec ${l.getExe cell.operators.uwsgi}
          exec docker-compose -f ${cell.nixago.hello.configFile} up
        '';
        passthru = {
          dockerCompose = dockerCompose;
        };
      })
    // {
      process-compose = {
        depends_on = {
          "//example/oci-images/hello" = {
            condition = "process_completed";
          };
        };
      };
    };
}
