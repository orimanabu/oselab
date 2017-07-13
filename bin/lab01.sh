oc login -u devel
oc create -f hello-pod-x4.json 
oc create -f hello-service.json 
oc create -f hello-route.yml 
#oc expose svc hello-openshift --hostname hello.app.example.com
curl hello-openshift.app.example.com

oc new-project proj1
oc new-app --template=mysql-ephemeral --name=database --param MYSQL_USER=mysqluser --param MYSQL_PASSWORD=redhat --param MYSQL_DATABASE=mydb --param DATABASE_SERVICE_NAME=database
mysql -umysqluser -predhat -h $(oc get svc database --template='{{.spec.clusterIP}}') -e 'show databases;'

oc new-project proj2
oc new-app --template=mysql-ephemeral --name=database --param MYSQL_USER=mysqluser --param MYSQL_PASSWORD=redhat --param MYSQL_DATABASE=mydb --param DATABASE_SERVICE_NAME=database
mysql -umysqluser -predhat -h $(oc get svc database --template='{{.spec.clusterIP}}') -e 'show databases;'

oc new-app -i openshift/ruby https://github.com/openshift/ruby-hello-world MYSQL_USER=mysqluser MYSQL_PASSWORD=redhat MYSQL_DATABASE=mydb
oc expose svc ruby-hello-world --hostname hello.app.example.com
oc scale --replicas=6 dc ruby-hello-world
