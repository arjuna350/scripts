#!/bin/sh

APPNAME="DQ Agent"

APPBASE=$(dirname "$0")
APPCODE=dqAgent


DQAGENT_STORAGE=$APPBASE/filesystem/
DQAGENT_LOGPATH=$APPBASE/logs/dq-axon/dqagent.log
DQMAINCLASS=com.infa.products.dq.agent.beans.application.DQAgentApplication
APPOPTS="-XX:-LoopUnswitching -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled"
CLASSPATH="$APPBASE/dq-axon/*:$APPBASE/conf:$APPBASE/lib/*"



export DQAGENT_STORAGE

pid() {
    ps -ef | grep ${DQMAINCLASS} | grep -v grep | awk '{print $2}'
}

echo "Environment validation Start ..."


JAVA_VER=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*"/\1\2/p;')
if [ $JAVA_VER -gt 17 ] ; then
		echo "Java version validation passed "  
else
		echo "DQ Agent require java version equal or greater than 1.8" 
		exit 0
fi

echo "Environment validation complete ..."

PID=$(pid)

if [ ! -z "$PID" ];
then
	echo "DQ Agent is already running."
else
	echo "Starting $APPNAME server ..."
	#start DQ Agent
	java -cp $CLASSPATH $DQMAINCLASS $@  2>> /dev/null >> /dev/null &
	echo "$APPNAME initialized! . Monitor log at $DQAGENT_LOGPATH "
fi

