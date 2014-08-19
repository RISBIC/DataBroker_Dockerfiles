#!/bin/sh


rm -rf DataBroker DataFlow_Utilities Simple_DataBroker_PlugIn

git clone --branch docker https://github.com/RISBIC/DataBroker.git
(cd DataBroker; mvn install)

git clone --branch docker https://github.com/RISBIC/DataFlow_Utilities.git
(cd DataFlow_Utilities; mvn install)

git clone --branch docker https://github.com/RISBIC/Simple_DataBroker_PlugIn.git
(cd Simple_DataBroker_PlugIn; mvn install)
