#!/usr/bin/env python

from datetime import datetime
from elasticsearch import Elasticsearch

es_conn = Elasticsearch(
    ['192.168.200.10'],
    http_auth=('elastic', 'rPz1ZRnowQw5ckgF9Jow'),
    scheme="http",
    port=9200,
    )

# List indices of elasticsearch server
indices_list=es_conn.indices.get_alias('*')
print (indices_list)
