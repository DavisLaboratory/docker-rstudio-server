FROM ubuntu:14.04
MAINTAINER Soroor Hediyeh Zadeh <hediyehzadeh.s@wehi.edu.au>
RUN echo "deb http://cran.ms.unimelb.edu.au/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list   
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9  
RUN add-apt-repository ppa:marutter/rdev
RUN apt-get update  
RUN apt-get upgrade
RUN apt-get install -y -q r-base r-base-dev gdebi-core libapparmor1 supervisor wget git
RUN (wget https://download2.rstudio.org/rstudio-server-0.99.902-amd64.deb && gdebi -n rstudio-server-0.99.902-amd64.deb)
RUN rm /rstudio-server-0.99.902-amd64.deb
RUN (adduser --disabled-password --gecos "" davislab && echo "davislab:davislab"|chpasswd)
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787
CMD ["/usr/bin/supervisord"]
