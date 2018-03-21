#!/bin/bash
# Parse PASSWORD_RESPONSE and return kibana | elastic | logstash passwords

export PATH=$PATH:/bin

PASSWORD_RESPONSE="/elasticsearchvm/secrets/passwd_response"

ELASTIC_PASSWD=$(cat $PASSWORD_RESPONSE | grep "PASSWORD elastic" | cut -d '=' -f 2- | cut -d '"' -f 1)
KIBANA_PASSWD=$(cat $PASSWORD_RESPONSE | grep "PASSWORD kibana" | cut -d '=' -f 2- | cut -d '"' -f 1)
LOGSTASH_PASSWD=$(cat $PASSWORD_RESPONSE | grep "PASSWORD logstash_system" | cut -d '=' -f 2- | cut -d '"' -f 1)


echo $KIBANA_PASSWD
echo $LOGSTASH_PASSWD
echo $ELASTIC_PASSWD

PASSWORD_FILE="/elasticsearchvm/secrets/passwd"
[ -e $PASSWORD_FILE ] && rm -rf $PASSWORD_FILE

typeset -A PASSWORD_DICT
PASSWORD_DICT=(
	[kibanapass]=$KIBANA_PASSWD
	[logpass]=$LOGSTASH_PASSWD
	[elaspass]=$ELASTIC_PASSWD
	)

echo "" > $PASSWORD_FILE
echo ${PASSWORD_DICT[elaspass]} | jq -R '.' >> $PASSWORD_FILE
echo ${PASSWORD_DICT[kibanapass]} | jq -R '.' >> $PASSWORD_FILE
echo ${PASSWORD_DICT[logpass]} | jq -R '.' >> $PASSWORD_FILE
