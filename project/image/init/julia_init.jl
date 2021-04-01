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
    pkg"add IJulia"; # IJulia Kernel
    pkg"add BenchmarkTools@0.7.0 CSV@0.8.4 CSVFiles@1.0.0 ColorTypes@0.8.1 Cubature@1.5.1 DataFrames@0.22.7 DifferentialEquations@6.16.0
	Distributions@0.24.15 ExcelFiles@1.0.0 FFTW@1.3.2 Flux@0.8.3 Formatting@0.4.2 HDF5@0.15.4 LaTeXStrings@1.2.1 LsqFit@0.12.0
	Measurements@2.5.0 Polynomials@2.0.5 ProgressMeter@1.5.0 PyCall@1.92.2 PyPlot@2.9.0 QuantumOptics@0.8.5 Traceur@0.3.1 Zygote@0.6.8"

    # precompile
    @info "Precompile all packages..."
    pkg"precompile"
end

install()
