FROM ubuntu:trusty

# Install curl as it is not available by default
RUN sudo apt-get update
RUN sudo apt-get install curl -y

# Setup buidkit
RUN curl -Ls https://civicrm.org/get-buildkit.sh | bash -s -- --full --dir ~/buildkit

# Update Node to latest version, otherwise phantomjs installation is failing
RUN sudo npm cache clean -f
RUN sudo npm install -g n
RUN sudo n stable
RUN sudo ln -sf /usr/local/n/versions/node/0.10/bin/node /usr/bin/node 
RUN sudo n latest


RUN ~/buildkit/bin/civi-download-tools


RUN chmod 777 -R ~/buildkit/


RUN ~/buildkit/bin/amp config:set \
  --db_type="mysql_dsn" \
  --mysql_dsn="mysql://root:root@192.168.99.100:3306" \
  --httpd_type="apache24" \
  --hosts_type="file" \
  --httpd_restart_command="sudo service apache2 restart" \
  --perm_type="none" \
  --perm_user="www"

RUN chmod 777 -R ~/.amp/

RUN echo 'Include /root/.amp/apache.d/*.conf' >> /etc/apache2/apache2.conf


# RUN ~/buildkit/bin/amp test

# Add to Path
#ENV PATH="~/buildkit/bin:$PATH"

# This is necessary othwerwise civibuild would fail because of bower error
RUN echo '{ "allow_root": true }' > /root/.bowerrc

# Create a CiviHR Project
RUN ~/buildkit/bin/civibuild create hr16 --civi-ver 4.7.15 --hr-ver staging --url http://192.168.99.100:8908


RUN sudo service apache2 restart

EXPOSE 8908