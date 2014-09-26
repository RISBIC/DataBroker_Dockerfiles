#
# Deploy a Fedora 20
#

# Use Fedora image as the base
FROM fedora:20

# Install packages: java & postgres
RUN yum -y install java-1.7.0-openjdk-devel postgresql postgresql-server; yum clean all

#
# Install Wildfly-8.1.0.Final with PostgreSQL 9.3 module
#

# Update package: bash - Patch to avoid "Shellshock" bug
RUN yum -y update bash; yum clean all

# Add the WildFly distribution to /opt
RUN cd /opt && curl http://download.jboss.org/wildfly/8.1.0.Final/wildfly-8.1.0.Final.tar.gz | tar zx &&\
    ln -s /opt/wildfly-8.1.0.Final /opt/wildfly

# Add management user
RUN /opt/wildfly/bin/add-user.sh -m -u risbic -p tsb --silent

# Download Postgres JDBC 4.1 driver into the module location
ADD http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar /opt/wildfly/modules/org/postgresql/main/

# Copy module.xml into place
ADD add_files/module.xml /opt/wildfly/modules/org/postgresql/main/

# Copy standalone.xml into place
ADD add_files/standalone.xml /opt/wildfly/standalone/configuration/

# Create the wildfly user and group, and change permissions
RUN groupadd -r wildfly &&\
    useradd -r -g wildfly -d /opt/wildfly -s /bin/bash -c "WildFly User" wildfly &&\
    chown -R wildfly:wildfly /opt/wildfly /opt/wildfly-8.1.0.Final

# Expose the Wildfly ports
EXPOSE 8080 8433 9990

#
# Setup PostgreSQL 9.3
#

ENV PGDATA /var/lib/pgsql/data
ENV PGPORT 5432
ENV PGUSER postgres

USER postgres

RUN /bin/initdb &&\
    pg_ctl start -l /tmp/serverlog &&\
    sleep 15 &&\
    createuser risbic &&\
    createdb --owner=risbic databroker &&\
    psql -c "ALTER USER risbic WITH PASSWORD 'tsb';" &&\
    psql -c "GRANT ALL PRIVILEGES ON DATABASE databroker TO risbic;" &&\
    echo "host all all 127.0.0.1/32 password" >> /var/lib/pgsql/data/pg_hba.conf

#
# Install DataBroker and WebPortal 
#

ADD DataBroker/webportal-ear/target/webportal-ear-1.0.0p1m2l.ear /opt/wildfly/standalone/deployments/webportal-ear-1.0.0p1m2l.ear
ADD DataBroker/server-ear/target/databroker.ear /opt/wildfly/standalone/deployments/databroker.ear
ADD Simple_DataBroker_PlugIn/simple-plugin-ear/target/simple-plugin-ear-1.0.0p1m2l.ear /opt/wildfly/standalone/deployments/simple-plugin-ear-1.0.0p1m2l.ear

#
# Run WildFly and PostgreSQL
#

USER root

ADD add_files/run.sh /root/run.sh

CMD /root/run.sh
