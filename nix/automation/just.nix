{
  fmt = {
    description = "Formats all changed source files";
    content = ''
      treefmt $(git diff --name-only --cached)
    '';
  };
  cachix-push = {
    description = "Uploads the build to cachix";
    content = ''
      nix build .\#x86_64-linux.kernels.packages.jupyterEnvironment --json | jq -r '.[].outputs | to_entries[].value' | cachix push gtrunsec
    '';
  };
}
