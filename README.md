# DataBroker-Dockerfiles

Dockerfiles for creating DataBroker Web and DB containers

# Building the containers

In `./db`:

    docker build -t risbic:db .

In `./web`:

    docker build -t risbic:web .

# Running (and linking) the containers

    docker run -d --name db risbic:db
    docker run -d -P --name web --link db:db risbic:web

Then check the output of `docker ps` the `PORTS` column of the `web` row should contain something like:

    PORTS                                              NAMES
    0.0.0.0:49153->8080/tcp, 0.0.0.0:49154->9990/tcp   web

This means port `49153` forwards to the Web port (`8080`) on your WildFly instance and `49154` forwards to the Management port (`9990`). 

If you run docker locally you'd probably connect to <http://localhost:49153> in your browser, unless you use boot2docker in which case it might be something like <http://192.168.59.103:49153>.
