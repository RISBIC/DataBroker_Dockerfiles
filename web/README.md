# README docker/web

Contains a Dockerfile (and config files) to build a docker container (based off Fedora 20) with Wildfly 8 installed and configured for the DataBroker

## Building

**NOTE:** Please build and run a db container as described in `docker/db/README.md` first.

From the `docker/web` directory run:

    docker build -t risbic/web .

Then (with a container named db) execute the following:

    docker run -d -P --name web --link db:db risbic/web
