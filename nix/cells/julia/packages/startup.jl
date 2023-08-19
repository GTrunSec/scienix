import Pkg
prj = joinpath(ENV["PRJ_ROOT"], "nix/julia/packages")
Pkg.activate(prj)
Pkg.instantiate()
