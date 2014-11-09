# DataBroker-Dockerfiles

Dockerfiles for creating DataBroker single container or seperate Web and DB containers

Preperpared docker images can be downloaded for Docker Hub: https://hub.docker.com/u/risbic/

Building a single container
---------------------------

To build the container, in './databroker_webportal':

    ./prepare.sh
    docker build -t risbic/databroker_webportal .

To run the container, in './databroker_webportal':
 
    docker run -t -i -p 80:8080 -p 443:8433 -p 9990:9990 --name databroker risbic/databroker_webportal

    (The command "systemctl stop firewalld.service" could be useful, on Fedora 20, to disable the firewall)

The latest stable version of this image is available from git hub, using the command:

    docker pull risbic/databroker_webportal:latest

Building the seperate containers
--------------------------------

In './db':

    docker build -t risbic/db .

In './web':

    docker build -t risbic/web .

# Running (and linking) the containers

    docker run -d --name db1 risbic/db
    docker run -d -P --name web1 --link db1:db risbic/web

Then check the output of 'docker ps' the 'PORTS' column of the 'web' row should contain something like:

    PORTS                                              NAMES
    0.0.0.0:49153->8080/tcp, 0.0.0.0:49154->9990/tcp   web

This means port '49153' forwards to the Web port ('8080') on your WildFly instance and '49154' forwards to the Management port ('9990'). 

You can control the forwarding behaviour (and ports) through the use of the '-p' parameter of the 'docker run' command. See <http://docs.docker.com/userguide/dockerlinks/> for more information.

If you run docker locally you'd probably connect to <http://localhost:49153> in your browser, unless you use boot2docker in which case it might be something like <http://192.168.59.103:49153>.

