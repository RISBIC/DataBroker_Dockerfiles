# README docker/db

Contains a Dockerfile to build a docker container (based on Ubuntu 14.04) with Postgres 9.3 installed and configured for the DataBroker

## Building

From the `docker/db` directory run:

    docker build -t broker:db .

Then execute the following:

    docker run -d --name db broker:db