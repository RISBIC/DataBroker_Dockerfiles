#!/bin/sh

su - postgres --command="pg_ctl start -l /tmp/serverlog"

sleep 5

su - wildfly --command="/opt/wildfly/bin/standalone.sh -b=0.0.0.0 -bmanagement=0.0.0.0"
