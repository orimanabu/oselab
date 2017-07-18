#!/bin/bash

mysql -umysqluser -predhat -h $(oc get svc database --template='{{.spec.clusterIP}}') -e 'show databases;'
echo "=> dump-flows"
sudo ovs-dpctl dump-flows
echo "=> dump-flows -m"
sudo ovs-dpctl dump-flows -m
