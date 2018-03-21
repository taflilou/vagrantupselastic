#!/bin/bash
# Parse PASSWORD_FILE and return elastic password

ELASTICPASS=$(cat /elasticsearchvm/secrets/passwd | awk -F "\"" 'NR==2 { print $2 }')
#cat /elasticsearchvm/secrets/passwd | awk -F "\"" 'NR==2 { print $2 }'
#echo $ELASTICPASS
sed "s/ELASTICSEARCH_PASSWORD/$ELASTICPASS/g" /elasticsearchvm/conf/kibana.yml.templ > /elasticsearchvm/conf/kibana.yml.dest
