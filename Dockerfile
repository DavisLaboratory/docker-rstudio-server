FROM ubuntu:14.04
MAINTAINER Soroor Hediyeh Zadeh <hediyehzadeh.s@wehi.edu.au>
RUN apt-get -qqy update
RUN apt-get install -y -q r-base r-base-dev gdebi-core libapparmor1 supervisor wget git
RUN (wget https://download2.rstudio.org/rstudio-server-0.99.902-amd64.deb && gdebi -n rstudio-server-0.99.902-i386.deb)
RUN rm /rstudio-server-0.99.902-i386.deb
RUN (adduser --disabled-password --gecos "" davislab && echo "davislab:davislab"|chpasswd)
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8787
CMD ["/usr/bin/supervisord"]
