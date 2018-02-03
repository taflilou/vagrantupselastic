!#/bin/bash
# Parse PASSWORD_RESPONSE and return kibana | elastic | logstash passwords

PASSWORD_RESPONSE="/elasticsearchvm/secrets/passwd_response"

KIBANA_PASSWD=$(cat $PASSWORD_RESPONSE | grep 'PASSWORD kibana' | cut -d '=' -f 2- | cut -d '"' -f 1)
LOGSTASH_PASSWD=$(cat $PASSWORD_RESPONSE | grep 'PASSWORD logstash_system' | cut -d '=' -f 2- | cut -d '"' -f 1)
ELASTIC_PASSWD=$(cat $PASSWORD_RESPONSE | grep 'PASSWORD elastic' | cut -d '=' -f 2- | cut -d '"' -f 1)

PASSWORD_FILE="/elasticsearchvm/secrets/passwd"
echo "" > $PASSWORD_FILE
# echo -e "Kibana password:\t $KIBANA_PASSWD" >> $PASSWORD_FILE
# echo -e "Logstash password:\t $LOGSTASH_PASSWD" >> $PASSWORD_FILE
# echo -e "Elastic password:\t $ELASTIC_PASSWD" >> $PASSWORD_FILE

echo -e "Kibana password:\t $KIBANA_PASSWD"
echo -e "Logstash password:\t $LOGSTASH_PASSWD"
echo -e "Elastic password:\t $ELASTIC_PASSWD" 