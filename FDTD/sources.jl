using Printf
using Plots
#using PhysicalConstants.CODATA2018
#import PhysicalConstants.CODATA2018: c_0, μ_0, ε_0
#=
mutable struct Gaussian
    Δt::Float64
    cwv::Float64 # Center wavelength
    spread::Float64 # spread
    peak_pos::Float64 # Peak location in time-domain.
end
=#

c0 = 299792458
mu0 = 4*π*10^(-7)

um = 1e-6
nm = 1e-6

Lx, Ly, Lz = 128*10*um, 128*10*um, 128*10*um
Nx, Ny, Nz = 128, 128, 128
dx, dy, dz = Lx/Nx, Ly/Ny, Lz/Nz

courant = 1/4
dt = courant * min(dx,dy,dz) / c0
Tsteps = 3001

cwv = 300*um
interval = 2
spread   = 0.3
peak_pos = 1000
plot_per = 100

function gaussian(tstep, dt, cwv, spread, peak_pos)::Float64
    cfreq = c0 / cwv
    w0 = 2*π*cfreq
    ws = spread *w0
    ts = 1/ws
    tc = peak_pos * dt
    tt = tstep*dt - tc
    pulse_re = exp((-.5) * ((tt*ws)^2)) * cos(w0*tt)
    return pulse_re
end

gauss = gaussian(peak_pos, dt, cwv, spread, peak_pos)
@printf("%e", gauss)