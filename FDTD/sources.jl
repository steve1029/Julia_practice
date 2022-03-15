using PhysicalConstants.CODATA2018
#=
mutable struct Gaussian
    Δt::Float64
    cwv::Float64 # Center wavelength
    spread::Float64 # spread
    peak_pos::Float64 # Peak location in time-domain.
end
=#
function gaussian(dt::Float64,cwv::Float64,
    spread::Float64, peak_pos::Float64)::Float64
    cfreq = c_0 / cwv
    return cfreq
end

gauss = gaussian(1,100,5,50)
println(gauss)