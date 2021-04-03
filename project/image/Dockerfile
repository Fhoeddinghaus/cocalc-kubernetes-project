FROM sagemathinc/cocalc-kubernetes-project

USER root

# Preparing Julia installation for later build

# Install Julia
ARG JULIA=1.6.0
RUN cd /tmp \
  && wget https://julialang-s3.julialang.org/bin/linux/x64/${JULIA%.*}/julia-${JULIA}-linux-x86_64.tar.gz \
  && tar xf julia-${JULIA}-linux-x86_64.tar.gz -C /opt \
  && rm  -f julia-${JULIA}-linux-x86_64.tar.gz \
  && mv /opt/julia-* /opt/julia \
  && ln -s /opt/julia/bin/julia /usr/local/bin


# Use own init script
COPY init /cocalc/init/

RUN sudo mkdir -p /usr/share/julia \
  && export JULIA_DEPOT_PATH=/usr/share/julia \
  && julia /cocalc/init/julia_init.jl --install-min \
  && chmod -R ag+rw /usr/share/julia


USER user

WORKDIR /home/user

EXPOSE 2222 6000 6001

ENV HOME=/home/user

ENTRYPOINT ["/cocalc/bin/tini", "--"]
CMD ["sh", "-c", "env -i /cocalc/init/init.sh $COCALC_PROJECT_ID"]
