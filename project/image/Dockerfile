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

USER user

WORKDIR /home/user

EXPOSE 2222 6000 6001
  

ENTRYPOINT ["/cocalc/bin/tini", "--"]
CMD ["sh", "-c", "env -i /cocalc/init/init.sh $COCALC_PROJECT_ID"]
