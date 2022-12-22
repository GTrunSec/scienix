import Pkg
prj = joinpath(ENV["PRJ_ROOT"], "playground")
Pkg.activate(prj)
Pkg.instantiate()
