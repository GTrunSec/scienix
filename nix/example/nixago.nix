{
  inputs,
  cell,
}:
builtins.mapAttrs (_: inputs.std.lib.dev.mkNixago) {
  hello = {
    configData = cell.composeJobs.hello.passthru.dockerCompose;
    output = "modules/infra/hello/docker-compose.yaml";
    format = "yaml";
    hook.mode = "copy";
  };
  nginx = {
    configData = {
      version = "3.7";
      services = {
        nginx = {
          image = "nginx:1.19.2";
          ports = [ "80:80" ];
          volumes = [ "./modules/infra/hello/nginx.conf:/etc/nginx/conf.d/default.conf" ];
        };
      };
    };
    output = "modules/infra/nginx/docker-compose.yaml";
    format = "yaml";
    hook.mode = "copy";
  };
}
