# Use latest Fedora image as the base
FROM fedora

# Install java
RUN yum -y install java-1.8.0-openjdk-devel

# Clean the metadata
RUN yum clean all

# Add the WildFly distribution to /opt
RUN cd /opt && curl http://download.jboss.org/wildfly/8.1.0.Final/wildfly-8.1.0.Final.tar.gz | tar zx

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/wildfly-8.1.0.Final /opt/wildfly

# Add management user
RUN /opt/wildfly/bin/add-user.sh -m -u risbic -p tsb --silent

# Download Postgres JDBC 4.1 driver into the module location
ADD http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar /opt/wildfly/modules/org/postgresql/main/

# Copy module.xml into place
ADD module.xml /opt/wildfly/modules/org/postgresql/main/

# Copy standalone.xml into place
ADD standalone.xml /opt/wildfly/standalone/configuration/

# Create the wildfly user and group
# RUN groupadd -r wildfly
# RUN useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly User" wildfly

# Change the owner of the /opt/wildfly directory
# RUN chown -R wildfly:wildfly /opt/wildfly

# Run everything below as the wildfly user
# USER wildfly

# Expose the ports we're interested in
EXPOSE 8080 9990

# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]