{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeConfig writeShellApplication;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  vast =
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
          exec docker-compose -f ${cell.nixago.vast.configFile} up
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
