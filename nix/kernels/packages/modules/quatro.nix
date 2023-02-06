{
  inputs,
  cell,
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  types = lib.types;
  getEnv = k: x: builtins.head config.build.passthru.kernels."${config.kernel.${k}.${x}.name}-jupyter-kernel".kernelInstance.argv;
  cfg = config.publishers;
in {
  options = {
    quatroEnv = lib.mkOption {
      type = types.package;
      internal = true;
    };
    publishers = {
      quarto = lib.mkOption {
        default = {};
        description = "Quarto publisher configuration";
        example = ''
          rust = "<name>"
          python = "data-science";
          r = "data-science";
        '';
        type = types.submodule {
          options = {
            enable = lib.mkEnableOption (lib.mkDoc "whether to enable the quarto publisher");
            package = lib.mkOption {
              type = types.package;
              default = pkgs.quarto;
              defaultText = "pkgs.quarto";
              description = "Quarto package to use.";
            };
          };
        };
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.quarto.enable {
      quatroEnv = inputs.cells.quarto.lib.mkQuarto {
        text = let
          syncKernels = lib.concatMapStringsSep "\n" (p: ''
            rsync --chmod +rw -avzh ${p}/kernels/${p.kernelInstance.name} \
            "$HOME"/.local/share/jupyter/kernels
          '') (lib.attrValues config.build.passthru.kernels);
        in ''
          if [ ! -d "$HOME"/.local/share/jupyter/kernels ]; then
              mkdir -p "$HOME"/.local/share/jupyter/kernels
          fi
          # $(git rev-parse --show-toplevel)
          ${syncKernels}
          quarto "$@"
        '';
      };
    })
  ];
}
