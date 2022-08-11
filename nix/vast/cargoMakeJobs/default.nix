{
  inputs,
  cell,
}: {
  vast-integration.tasks = {
    smtp-url = {
      description = "Check smtp log with vast";
      command = "vast-integration";
      args = ["-s" "./conf/tenzir-vast-integration.yaml" "-t" "SMTP log url"];
    };
  };
}
