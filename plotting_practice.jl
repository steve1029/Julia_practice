# install a 'Plots' package.
# DifferentialEquations.jl is a package for solving numerically solving differential equations in Julia by Chris Rackauckas.
# For more info, see https://docs.juliaplots.org/latest/ecosystem/#ecosystem
# and https://github.com/SciML/DifferentialEquations.jl
#=
import Pkg
Pkg.add("Plots")
Pkg.rm("DifferentialEquations")
=#
using Plots
x = 1:10;
y = rand(10,3);
println(size(y))

fig1 = plot(x,y)
display(fig1)
#sleep(5)
readline()