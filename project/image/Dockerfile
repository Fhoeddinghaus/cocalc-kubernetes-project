FROM sagemathinc/cocalc-kubernetes-project

USER root

# Preparing Julia installation for later build

# Install Julia
ARG JULIA=1.5.0
RUN cd /tmp \
  && wget https://julialang-s3.julialang.org/bin/linux/x64/${JULIA%.*}/julia-${JULIA}-linux-x86_64.tar.gz \
  && tar xf julia-${JULIA}-linux-x86_64.tar.gz -C /opt \
  && rm  -f julia-${JULIA}-linux-x86_64.tar.gz \
  && mv /opt/julia-* /opt/julia \
  && ln -s /opt/julia/bin/julia /usr/local/bin
  
# Install IJulia kernel
#RUN echo 'using Pkg; Pkg.add("IJulia");' | julia
#  && mv -i "$HOME/.local/share/jupyter/kernels/julia-${JULIA%.*}" "/usr/local/share/jupyter/kernels/"
#"/opt/julia/share/julia/site"; \

#RUN \
#     umask 022 \
#  && echo '\
#  ENV["JUPYTER"] = "/usr/bin/jupyter"; \
#  ENV["JULIA_PKGDIR"] = "/root/.julia/packages"; \ 
#  using Pkg; \
#  Pkg.add("IJulia");' | julia \
#  && mv -i "$HOME/.local/share/jupyter/kernels/julia-${JULIA%.*}" "/usr/local/share/jupyter/kernels/" \
#  && (mkdir "/usr/local/share/.julia" || true) \
#  && mv -i "$HOME/.julia/packages" "/usr/local/share/.julia/" \
#  && echo '{\
#  "display_name": "Julia 1.5.0",\
#  "argv": [\
#    "/opt/julia/bin/julia",\
#    "-i",\
#    "--color=yes",\
#    "--project=@.",\
#    "/usr/local/share/.julia/packages/IJulia/IDNmS/src/kernel.jl",\
#    "{connection_file}"\
#  ],\
#  "language": "julia",\
#  "env": {},\
#  "interrupt_mode": "signal"\
#}' > /usr/local/share/jupyter/kernels/julia-${JULIA%.*}/kernel.json
#Pkg.init(); \

# Change permissions and ownership
#RUN \
#     chown -R user:user /usr/local/share/.julia \
#  && chmod -R 755 /usr/local/share/.julia

USER user

WORKDIR /home/user

EXPOSE 2222 6000 6001

ENTRYPOINT ["/cocalc/bin/tini", "--"]
CMD ["sh", "-c", "env -i /cocalc/init/init.sh $COCALC_PROJECT_ID"]

RUN \
     umask 022 \
  && echo '\
  ENV["JUPYTER"] = "/usr/bin/jupyter"; \
  ENV["JULIA_PKGDIR"] = "/home/user/.julia/packages"; \ 
  using Pkg; \
  Pkg.add("IJulia");' | julia 
  #\
  #&& mv -i "/home/user/.local/share/jupyter/kernels/julia-${JULIA%.*}" "/usr/local/share/jupyter/kernels/"


