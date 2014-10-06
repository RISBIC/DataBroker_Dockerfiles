Dockerfiles for creating DataBroker single container or seperate Web and DB containers

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

