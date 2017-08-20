#!/bin/sh


APPNAME="DQ Agent"

APPBASE=$(dirname "$0")
APPCODE=dqAgent

DQAGENT_LOGPATH=$APPBASE/logs/dq-axon/dqagent.log
DQMAINCLASS=com.infa.products.dq.agent.beans.application.DQAgentApplication



pid() {
    ps -ef | grep ${DQMAINCLASS} | grep -v grep | awk '{print $2}'
}


PID=$(pid)

if [ ! -z "$PID" ];
then
	echo "DQ Agent shutting down. Monitor log at $DQAGENT_LOGPATH "
	kill  $PID
else
	echo "DQ Agent is not running."
fi
 
 

