FROM centos:7 

# Install packages, EPEL must come first 
RUN yum -y update && yum -y install epel-release
RUN yum -y install wget gd gd-devel wget httpd php gcc make perl tar unzip libcurl-devel \
  nagios nagios-plugins-ifoperstatus nagios-plugins-ifstatus \
  nagios-plugins-all nagios-plugins-nrpe nagios-plugins-apt \
  supervisor mod_ldap

## install perl modules for nagios plugins

RUN yum -y install perl-Data-Dumper perl-WWW-Curl perl-JSON

RUN cd /tmp && wget https://labs.consol.de/assets/downloads/nagios/check_mysql_health-2.2.2.tar.gz 
RUN cd /tmp && tar xvzf check_mysql_health-2.2.2.tar.gz 
RUN cd /tmp/check_mysql_health-2.2.2 && ./configure --with-nagios-user=root --with-nagios-group=root && make && make install

RUN cd /tmp && wget http://www.cpan.org/authors/id/J/JE/JESUS/Net--RabbitMQ-0.2.8.tgz
RUN cd /tmp && tar xvzf Net--RabbitMQ-0.2.8.tgz
RUN cd /tmp/Net--RabbitMQ-0.2.8 && perl Makefile.PL && make && make install

# COPY the existing plugins if any to new server

# supervisor configuration
ADD supervisord.conf /etc/supervisord.conf

# add ldap config for nagios
ADD nagios.conf /etc/httpd/conf.d/nagios.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
