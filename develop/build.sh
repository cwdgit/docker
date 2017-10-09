#!/bin/sh


# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`


me=`whoami`

echo "Hi,the user running this build.sh is ${me} "

cd $SCRIPTPATH
rm -rf assets/web
cp -r ../../web/target/web  assets/

#cookbook
echo "arg1"$1
#domain name
echo "arg2"$2
#version
echo "arg3"$3
#image project
echo "arg4"$4
SERVERNAME=$1
SERVERADDRESS=$2
NEWVERSION=$3
PROJECT=$4
#cookbook:   zabbix_server_master
COOKBOOK=$SERVERNAME
#container:  zabbix_server_master_container
CONTAINER=$COOKBOOK"_container"
#node-name : zabbix_server_master_node
NODENAME=$COOKBOOK"_node"

REPOSITORY="registry.com/"$PROJECT
echo "registryname="$REPOSITORY
NAME=$SERVERNAME
VERSION=$NEWVERSION
DOCKER_OPTS="-H unix:///var/run/docker.sock"

#build the cookbook

/var/lib/jenkins/buildcook.sh $COOKBOOK $SERVERADDRESS $VERSION

#upload the tag
/var/lib/jenkins/uptag.sh $VERSION $COOKBOOK

# build a image

docker build -t $REPOSITORY/$NAME:$VERSION $SCRIPTPATH \
&& docker push $REPOSITORY/$NAME:$VERSION              \
&& docker rmi -f $REPOSITORY/$NAME:$VERSION            \
&& cd /opt/chef-repo                                   \
&& knife bootstrap $SERVERADDRESS --ssh-user root -P 'china-ops' --sudo --node-name $NODENAME --run-list 'recipe['$COOKBOOK']' 


