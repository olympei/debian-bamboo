# Install Atlassian Jira in Debian Stretch (x64bit)
FROM debian:stretch
MAINTAINER Thinegan Ratnam <thinegan@thinegan.com>

# Environment Config
ENV BAMBOO_HOME     /home/www/public_html/bamboo-data.server.com
ENV BAMBOO_INSTALL  /home/www/public_html/bamboo-install.server.com
ENV BAMBOO_VERSION  6.1.1
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV WORKDIR         /home/www/public_html
ENV BAMBOO_USER     bamboo
ENV BAMBOO_GROUP    bamboo

# https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-6.1.1.tar.gz
# tar -xf atlassian-bamboo-6.1.1.tar.gz

# Jira require prerequisites install
RUN \
  apt-get update && \
  apt-get install -y software-properties-common gnupg curl wget xmlstarlet

# Install Java.
RUN \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Create a dedicated user to run Bamboo in Linux
RUN \
  /usr/sbin/useradd --create-home --home-dir /home/bamboo --shell /bin/bash bamboo


# Install Bamboo
RUN \
  mkdir -p ${BAMBOO_HOME} && \
#  mkdir -p ${BAMBOO_INSTALL} && \
  cd ${WORKDIR} && \
  wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz && \
  tar -xf atlassian-bamboo-${BAMBOO_VERSION}.tar.gz

# Install symlink, chmod, chown folder
RUN \
  ln -sf ${WORKDIR}/atlassian-bamboo-${BAMBOO_VERSION} ${BAMBOO_INSTALL} && \
  chmod +x ${BAMBOO_INSTALL} && \
  chmod +x ${WORKDIR}/atlassian-bamboo-${BAMBOO_VERSION} && \
  chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} ${BAMBOO_INSTALL} && \
  chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} ${BAMBOO_HOME} && \
  chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} ${WORKDIR}/atlassian-bamboo-${BAMBOO_VERSION} && \
  echo "bamboo.home= ${BAMBOO_INSTALL}" >> ${WORKDIR}/atlassian-bamboo-${BAMBOO_VERSION}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties

# Install Bamboo as service
#COPY ./bamboo.service /etc/init.d/bamboo
#RUN chmod +x /etc/init.d/bamboo
#RUN update-rc.d bamboo defaults

#Install Run Bamboo symlink
RUN \
 ln -sf ${BAMBOO_INSTALL}/bin/start-bamboo.sh /usr/bin/bamboo && \
#  ln -sf ${BAMBOO_INSTALL}/bin/startup.sh /usr/bin/bamboo && \
 chmod +x /usr/bin/bamboo

# # Install Run Bamboo service
# RUN \
#   echo "#!/bin/bash" >> /usr/bin/bamboo && \
# #  echo "BAMBOO_USER='${BAMBOO_USER}'" >> /usr/bin/bamboo && \
# #  echo "BAMBOO_INSTALL='${BAMBOO_INSTALL}'" >> /usr/bin/bamboo && \
#   echo "nohup su - $BAMBOO_USER -c $BAMBOO_INSTALL/bin/start-bamboo.sh &" >> /usr/bin/bamboo && \
#   chmod +x /usr/bin/bamboo

# Post Cleanup
RUN \
  rm -rf atlassian-bamboo-${BAMBOO_VERSION}.tar.gz

# Define working directory.
WORKDIR ${BAMBOO_HOME}

# Startup
EXPOSE 8085

# Define default command.
#CMD ["su" "-" "${BAMBOO_USER}" "-c" "bamboo", "run"]
#CMD ["su", "-", "bamboo", "-c", "/usr/bin/bamboo", "run"]
#CMD ["bamboo", "run"]
CMD ["bamboo", "run"]
#CMD /usr/bin/bamboo
#CMD /run.sh
#CMD ["su", "-", "${BAMBOO_USER}", "-c", "${BAMBOO_INSTALL}/bin/start-bamboo.sh", "run"]
#ENTRYPOINT ["su", "-", "bamboo", "-c", "/usr/bin/bamboo"]
# su - bamboo -c /home/www/public_html/bamboo-dev.timeclone.com/bin/start-bamboo.sh


