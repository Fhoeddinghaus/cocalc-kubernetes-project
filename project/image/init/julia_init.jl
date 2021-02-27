ENV["JUPYTER"] = "/usr/bin/jupyter";
ENV["JULIA_PKGDIR"] = "/home/user/.julia/packages";
using Pkg; 
Pkg.add("IJulia");
Pkg.add("PyPlot");
