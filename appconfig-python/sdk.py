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

from ibm_appconfiguration import AppConfiguration
import json

def initialize(region, guid, apikey, collection_id, environment_id):
    global appconfig_client
    appconfig_client = AppConfiguration.get_instance()
    appconfig_client.init(region=region,
                          guid=guid,
                          apikey=apikey)
    appconfig_client.set_context(collection_id=collection_id,
                                 environment_id=environment_id)

def get_config_json(entity_id, entity_attributes, appconfig_features, appconfig_properties):
    appconfig_dictionary = {}
    for feat in appconfig_features:
        feat_value = get_feature(entity_id, feat, entity_attributes)
        appconfig_dictionary[feat] = feat_value

    for prop in appconfig_properties:
        prop_value = get_property(entity_id, prop, entity_attributes)
        appconfig_dictionary[prop] = prop_value
    
    jsonString = json.dumps(appconfig_dictionary, indent=4)
    return jsonString


def get_property(entity_id, property_id, entity_attributes={}):
    property = appconfig_client.get_property(property_id)
    return property.get_current_value(entity_id=entity_id, entity_attributes=entity_attributes)

def get_feature(entity_id, feature_id, entity_attributes):
    feature = appconfig_client.get_feature(feature_id)
    return feature.get_current_value(entity_id=entity_id, entity_attributes=entity_attributes)