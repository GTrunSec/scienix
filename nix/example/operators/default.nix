{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.ops) mkOperable;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  uwsgi = let
    uwsgi = nixpkgs.uwsgi.override {
      python3 = nixpkgs.python3;
      plugins = ["python3"];
    };
  in
    mkOperable rec {
      package = uwsgi;
      runtimeEnv = {
        PYTHON = nixpkgs.python3.withPackages (p: [p.flask]);
      };
      runtimeScript = ''
        ${l.getExe package} --plugin=python3 --http :9090 -H "$PYTHON" --callable app \
        --wsgi-file ./hello.py
      '';
    };
}
