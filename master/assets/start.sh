#!/bin/bash

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`


me=`whoami`

echo "Hi,the user running this build.sh is ${me} "

cd $SCRIPTPATH


exec ${CATALINA_HOME}/bin/catalina.sh run
