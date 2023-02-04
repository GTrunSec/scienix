# DeSci

## Enter default shell Environment

```sh
direnv allow
nix develop

```

## Launch the JupyterLab with Nix

```bash
nix develop --command jupyenv <IP> <PORT>
```

## Launch the Julia Pluto Notebook with Nix

```bash
nix develop --command pluto <IP> <PORT>
```
