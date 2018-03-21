#!/usr/bin/env python
# Create an index in Elasticsearch server and send access logs to Elasticsearch

# ====== EDITABLE VARIABLES ======
ES_PASSWORD="rPz1ZRnowQw5ckgF9Jow"
LOGS_PATH="../../capfi_web/dest/6st_access.log"
MYINDEX="access_sixsens"
# ================================

import re
from datetime import datetime
from elasticsearch import Elasticsearch

myes = Elasticsearch(
	['192.168.200.10'],
    http_auth=('elastic', ES_PASSWORD),
    scheme="http",
    port=9200,
	)

# headernames=['ip_address','identd','userid','request_time','request_line', 'status_code', 'object_size']
# # Create the data to bulk in Elasticsearch
# with open(LOGS_PATH,'r') as logfile:
# 	bulk_data=[]
# 	doc_id=0
# 	for item in logfile:
# 		doc_id+=1
# 		itemlist=re.split('\"',item)
# 		# Get the differents fields of 'headernames' in variables
# 		ip_address = itemlist[0].split()[0]
# 		identd = itemlist[0].split()[1]
# 		userid = itemlist[0].split()[2]
# 		request_time = (itemlist[0].split()[3] + ' ' + itemlist[0].split()[4]).strip('[]')
# 		request_line = itemlist[1]
# 		status_code = itemlist[2].split(' ')[1]
# 		object_size = itemlist[2].split(' ')[2]
		
# 		logdata = {}
# 		for i in range (len(headernames)):
# 			# logdata[headernames[i]] = item[i]
# 			logdata['ip_address'] = ip_address
# 			logdata['identd'] = identd
# 			logdata['userid'] = userid
# 			logdata['request_time'] = request_time
# 			logdata['request_line'] = request_line
# 			logdata['status_code'] = status_code
# 			logdata['object_size'] = object_size
# 		index_dict = {
# 			"index": {
# 				"_index": MYINDEX,
# 				"_type": "access",
# 				#"_id": "accessid"
# 				"_id": doc_id
# 			}
# 		}
# 		# print(logdata)
# 		bulk_data.append(index_dict)
# 		bulk_data.append(logdata)

# # Create accesslog index for 6eme Sens
# if myes.indices.exists(MYINDEX):
# 	print("=> Deleting the following index: %s" % (MYINDEX))
# 	delresult=myes.indices.delete(index=MYINDEX)
# 	print("=> DELETE: " % (delresult)) 

# print("Creating index %s into Elasticsearch ..." % (MYINDEX))
# create_index = myes.indices.create(index=MYINDEX)
# print("RESPONSE: %s " % (create_index))

# # Bulk the data in Elasticsearch
# print("Start bulking access data ....")
# bulk_result = myes.bulk(index=MYINDEX, body=bulk_data, refresh=True)

# Display the number of results
myresults = myes.search(index=MYINDEX, body={"query": {"match_all": {}}}, size=1000, from_=0)
hitsnumber=myresults['hits']['total']
#print(myresults['hits']['hits'])

for i in range(0,hitsnumber):
	print("=> " + str(myresults['hits']['hits'][i]))