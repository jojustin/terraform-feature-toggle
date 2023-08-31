# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from sdk import initialize, get_config_json
import json
import sys

ac_region = str(sys.argv[1])
ac_guid = str(sys.argv[2])
ac_apikey = str(sys.argv[3])
ac_collection_id = str(sys.argv[4])
ac_environment_id = str(sys.argv[5])
entity_id = str(sys.argv[6])
entity_attributes_input = str(sys.argv[7])
deployment_region = str(sys.argv[8])
appconfig_features = str(sys.argv[9]).split(',')
appconfig_properties = str(sys.argv[10]).split(",")

print(entity_attributes_input)
entity_attributes = json.loads(entity_attributes_input)
def init():
    initialize(ac_region, ac_guid, ac_apikey, ac_collection_id, ac_environment_id)

init()

get_config_json=get_config_json(entity_id, entity_attributes, appconfig_features, appconfig_properties)
print("get_config_json is ", get_config_json)

f = open("config.json", "w")
f.write(get_config_json)
f.close()