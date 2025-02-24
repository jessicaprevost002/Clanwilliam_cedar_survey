FROM rocker/r-ver:4.4.1

RUN apt-get update && apt-get install -y \
    libudunits2-0 \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('sf')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('lubridate')"

