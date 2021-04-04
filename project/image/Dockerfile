FROM sagemathinc/cocalc-kubernetes-project

USER root

# Installs Julia
ARG JULIA=1.6.0
RUN cd /tmp \
  && wget https://julialang-s3.julialang.org/bin/linux/x64/${JULIA%.*}/julia-${JULIA}-linux-x86_64.tar.gz \
  && tar xf julia-${JULIA}-linux-x86_64.tar.gz -C /opt \
  && rm  -f julia-${JULIA}-linux-x86_64.tar.gz \
  && mv /opt/julia-* /opt/julia \
  && ln -s /opt/julia/bin/julia /usr/local/bin


# Use own init script
COPY init /cocalc/init/

# Install necessary python package
RUN pip3 install --no-cache-dir xlrd


# Installs necessary packages (and IJulia) systemwide into /usr/share/julia
RUN sudo mkdir -p /usr/share/julia \
  && export JULIA_DEPOT_PATH=/usr/share/julia \
  && julia /cocalc/init/julia_init.jl --install \
  && chmod -R ugo+rwx /usr/share/julia \
  && chmod -R ugo+rwx /usr/share/julia/registries/General \
  && mv -i "$HOME/.local/share/jupyter/kernels/julia-${JULIA%.*}" "/usr/local/share/jupyter/kernels/" \
  && chmod -R ugo+rwx /usr/local/share/jupyter/kernels/julia-${JULIA%.*}


USER user

WORKDIR /home/user

EXPOSE 2222 6000 6001

ENV HOME=/home/user

ENTRYPOINT ["/cocalc/bin/tini", "--"]
CMD ["sh", "-c", "env -i /cocalc/init/init.sh $COCALC_PROJECT_ID"]
