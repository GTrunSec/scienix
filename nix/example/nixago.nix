{ inputs, cell }:
builtins.mapAttrs (_: inputs.std.lib.dev.mkNixago) {
  hello = {
    data = cell.composeJobs.hello.passthru.dockerCompose;
    output = "modules/infra/docker/hello/docker-compose.yaml";
    format = "yaml";
    hook.mode = "copy";
  };
}
