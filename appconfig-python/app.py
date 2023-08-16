from sdk import initialize, get_config_json

import sys

ac_region = str(sys.argv[1])
ac_guid = str(sys.argv[2])
ac_apikey = str(sys.argv[3])
ac_collection_id = str(sys.argv[4])
ac_environment_id = str(sys.argv[5])
entity_id = str(sys.argv[6])
deployment_region = str(sys.argv[7])

def init():
    initialize(ac_region, ac_guid, ac_apikey, ac_collection_id, ac_environment_id)

init()
entity_attributes = {
   'region': deployment_region 
}
get_config_json=get_config_json(entity_id, entity_attributes)
print("get_config_json is ", get_config_json)

f = open("config.json", "w")
f.write(get_config_json)
f.close()