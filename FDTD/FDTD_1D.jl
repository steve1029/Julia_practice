import PhysicalConstants.CODATA2018 as phy
using Printf

nm = 1e-9
um = 1e-6

tsteps = 1000
Nz = 10

eps = phy.VacuumElectricPermittivity
mu = phy.VacuumMagneticPermeability

Ex = zeros(Float64, Nz)
Hy = zeros(Float64, Nz)