{ inputs, cell }:
{
  vast.tasks = {
    smtp-url = {
      description = "Check smtp log with vast";
      command = "vast-integration";
      args = [
        "-s"
        "./conf/vast/vast-integration.yaml"
        "-t"
        "SMTP log url"
      ];
    };
  };
}
