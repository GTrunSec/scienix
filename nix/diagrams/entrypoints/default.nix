{
  inputs,
  cell,
}: let
  inherit (cell) lib cargoMakeJobs;
  inherit (inputs) nixpkgs matrix-attack-data;
  inherit (inputs.cells._common.lib) __inputs__;
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
in {
  zeek-smtp-dot = writeShellApplication {
    name = "zeek-smtp-dot";
    runtimeInputs = [nixpkgs.graphviz __inputs__.diagram2nix.graphviz.packages.yaml2dot];
    text = let
      data = (nixpkgs.formats.yaml {}).generate "data.yaml" matrix-attack-data.zeek.config.smtp;
    in ''
      yml2dot ${data} | dot -Tpng > "$PRJ_ROOT"/docs/zeek/zeek-smtp-dot.png
    '';
  };
  zeek-smtp-graphql = writeShellApplication {
    name = "zeek-smtp-graphql";
    runtimeInputs = [
      __inputs__.diagram2nix.graphql.packages.json-to-simple-graphql-schema
      __inputs__.diagram2nix.graphviz.packages.craftql
      nixpkgs.jq
    ];
    text = let
      data = (nixpkgs.formats.json {}).generate "data.json" cell.config.zeek-smtp;
      # https://github.com/walmartlabs/json-to-simple-graphql-schema/blob/master/test/fixtures/complex.json
    in ''
      # https://github.com/walmartlabs/json-to-simple-graphql-schema
      # https://github.com/yamafaktory/craftql
      # shellcheck disable=all
      cat ${data} | json-to-simple-graphql-schema > /tmp/output.graphql
      craftql /tmp/output.graphql > "$PRJ_ROOT"/docs/zeek/zeek-smtp-graphql.graphviz
    '';
  };
}
