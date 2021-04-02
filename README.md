# cocalc-kubernetes-project
 Docker image for cocalc-kubernetes-project, expanding the sagemathinc cocalc-kubernetes-project image by Julia and IJulia and other dependencies.

The Dockerfile extends the image https://hub.docker.com/r/sagemathinc/cocalc-kubernetes-project by installing the Julia language in the Dockerfile and customizing the /init/init.sh script to execute /init/julia_init.jl.

This image is used by the CIP-staff at THP (institute for theoretical physics) of the university cologne (UzK).

This repository is the cleaned result from what was learned in the original fork https://github.com/fhoeddinghaus/cocalc-kubernetes.