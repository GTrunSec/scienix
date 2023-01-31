{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeConfig writeShellApplication;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  hello =
    (let
      dockerCompose = writeConfig "dockerCompose.yaml" {
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
      inputs.std.lib.ops.writeShellApplication {
        name = "hello-deploy";
        runtimeInputs = [nixpkgs.docker-compose];
        text = ''
          exec ${l.getExe nixpkgs.docker-compose} -f ${dockerCompose} up
        '';
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
