ENV["JUPYTER"] = "/usr/bin/jupyter";
ENV["JULIA_PKGDIR"] = "/home/user/.julia/packages";

using Pkg; 
# Install the IJulia Kernel
#Pkg.add("IJulia");
# Moved to install()


# Installs all necessary packages in the global environment
## See https://github.com/markusschmitt/compphys2021/blob/main/tutorials/install.jl
get_global_env() = string("v", VERSION.major, ".", VERSION.minor)
get_global_env_folder() = joinpath(DEPOT_PATH[1], "environments", get_global_env())
get_active_env() = Base.active_project() |> dirname |> basename

# activate global environment (if not already active)
function activate_global_env()
    if get_active_env() != get_global_env()
        Pkg.REPLMode.pkgstr("activate --shared $(get_global_env())")
    end 
    nothing
end

# Installs all correct versions of our package dependencies.
function install()
    activate_global_env()

    # add all pkgs with specific versions (not pinned)
    @info "Installing packages..."
    # IJulia Kernel
    Pkg.add("IJulia")
    # Other packages
    Pkg.add(name="BenchmarkTools", version="0.7.0")
    Pkg.add(name="CSV", version="0.8.4")
    Pkg.add(name="CSVFiles", version="1.0.0")
    Pkg.add(name="ColorTypes", version="0.8.1")
    Pkg.add(name="Cubature", version="1.5.1")
    Pkg.add(name="DataFrames", version="0.22.7")
    Pkg.add(name="DifferentialEquations", version="6.16.0")
    Pkg.add(name="Distributions", version="0.24.15")
    Pkg.add(name="ExcelFiles", version="1.0.0")
    Pkg.add(name="FFTW", version="1.3.2")
    Pkg.add(name="Flux", version="0.8.3")
    Pkg.add(name="Formatting", version="0.4.2")
    Pkg.add(name="HDF5", version="0.15.4")
    Pkg.add(name="LaTeXStrings", version="1.2.1")
    Pkg.add(name="LsqFit", version="0.12.0")
    Pkg.add(name="Measurements", version="2.5.0")
    Pkg.add(name="Polynomials", version="2.0.5")
    Pkg.add(name="ProgressMeter", version="1.5.0")
    Pkg.add(name="PyCall", version="1.92.2")
    Pkg.add(name="PyPlot", version="2.9.0")
    Pkg.add(name="QuantumOptics", version="0.8.5")
    Pkg.add(name="Traceur", version="0.3.1")
    Pkg.add(name="Zygote", version="0.6.8")

    # precompile
    @info "Precompile all packages..."
    pkg"precompile"
end

install()
