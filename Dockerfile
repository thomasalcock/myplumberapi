FROM trestletech/plumber

RUN mkdir -p root/api/code
RUN mkdir -p root/api/data
RUN mkdir -p root/api/renv

COPY ./code root/api/code
COPY ./renv root/api/renv
COPY ./renv.lock root/api/renv.lock

WORKDIR /root/api

RUN R -e "install.packages('renv')"
RUN R -e "library('renv'); renv::consent(provided=TRUE)"
RUN R -e "renv::restore(confirm=FALSE)"
          
EXPOSE 8000

ENTRYPOINT ["R", "-e", \
"api <- plumber::plumb('code/main.R'); api$run(host = '0.0.0.0', port = 8000)"]