# Dockerfile
# Get RStudio with tidyverse and text publishing packages
FROM rocker/verse:4.0.2

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

# build package in the container and set repos
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org'))"
RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes = TRUE)"
