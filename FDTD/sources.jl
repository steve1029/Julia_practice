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

function gaussian(tstep, dt::Float64, cwv::Float64, spread::Float64, peak_pos::Int64)::Float64

    cfreq = c0 / cwv
    w0 = 2*π*cfreq
    ws = spread * w0
    ts = 1/ws
    tc = peak_pos * dt

    tt = tstep*dt - tc
    pulse_re = exp((-.5) * ((tt*ws)^2)) * cos(ws*tt)

    return pulse_re
end

function gaussian_plotting(tsteps, wvlens, dt, cwv, spread, peak_pos)
    
    cfreq = c0 / cwv
    w0 = 2*π*cfreq
    ws = spread * w0
    ts = 1/ws
    tc = peak_pos * dt
    freqs = c0 ./ wvlens

    tt = (tsteps.*dt .- tc) .* ws
    pulse_re = exp.((-.5) .* (tt.^2)) .* cos.(tt)
    pulse_im = exp.((-.5) .* (tt.^2)) .* sin.(tt)

    #println(size(vec(freqs)))
    #println(size(tsteps))

    # freqs and tsteps are vector. 
    # They should be converted to Matrix
    # before we operate outer product on them.
    #println(typeof(vec(freqs)))
    #println(typeof(tsteps))

    freqs = reshape(freqs, length(freqs), 1)
    tsteps = reshape(tsteps, 1, length(tsteps))

    # By reshape function, we can make an array to Matrix.
    #println(typeof(vec(freqs)))
    #println(typeof(tsteps))

    println(size(vec(freqs) * tsteps))
    println(size(exp.((1im*2*π*dt) .* (vec(freqs) * tsteps))))

    pulse_re_ft = sum((dt .* pulse_re) * exp.((1im*2*π) .* freqs .* dt .* tsteps))
    pulse_im_ft = sum((dt .* pulse_re) * exp.((1im*2*π) .* freqs .* dt .* tsteps))
    pulse_re_ft_amp = sqrt(sum(abs2.(pulse_re_ft)))
    pulse_im_ft_amp = sqrt(sum(abs2.(pulse_im_ft)))

    plot_t = plot(tsteps, gauss_ideal)
    plot_w = plot(wvlens, [pulse_re_ft_amp, pulse_im_ft_amp])
    plot_f = plot(freqs, [pulse_re_ft_amp, pulse_im_ft_amp])

    l = @layout [a b c]

    fig = plot(plot_t, plot_w, plot_f, layout=l)

    savefig(fig, "./gaussian.png")

end

if abspath(PROGRAM_FILE) == @__FILE__

    c0 = 299792458
    mu0 = 4*π*10^(-7)

    um = 1e-6
    nm = 1e-6

    Lx, Ly, Lz = 128*10*um, 128*10*um, 128*10*um
    Nx, Ny, Nz = 128, 128, 128
    dx, dy, dz = Lx/Nx, Ly/Ny, Lz/Nz

    courant = 1/4
    dt = courant * min(dx,dy,dz) / c0
    Tsteps = 3000

    cwv = 300*um
    interval = 2
    spread   = 0.3
    peak_pos = 1000
    plot_per = 100

    wvlens = collect(200*um:interval*um:600*um)
    #println(wvlens)
    freqs = c0 ./ wvlens
    t = collect(0:Tsteps)

    #println(t)
    #println(t.*2)
    #println(typeof(t))
    gauss = gaussian(peak_pos, dt, cwv, spread, peak_pos)
    #println(gauss)
    gauss_plot = gaussian_plotting(t, freqs, dt, cwv, spread, peak_pos)

end