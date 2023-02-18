{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.ops) mkStandardOCI;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  hello =
    (mkStandardOCI {
      name = "ghcr.io/gtrunsec/desci/hello";
      operable = cell.operators.uwsgi;
      tag = "latest";
      labels = {
        source = "github.com/gtrunsec/DeSci/exmaple/oci-images/hello";
      };
      options = {
        config = {
          WorkingDir = "/work";
          ExposedPorts = {
            "9090/tcp" = {};
          };
        };
      };
    })
    // {
      process-compose = {
        extraAttrPath = ["copyToPodman"];
      };
    };
}
