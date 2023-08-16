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

def get_config_json(entity_id, entity_attributes):
    worker_count_value = get_property(entity_id, "worker_count")
    vpc_cluster_flavor = get_property(entity_id, "vpc_cluster_flavor", entity_attributes)
    prefix = get_property(entity_id, "prefix")

    kms_config = get_feature(entity_id, "kms_config", entity_attributes)
    dictionary = {'worker_count': worker_count_value,
                  "vpc_cluster_flavor": vpc_cluster_flavor,
                  "prefix": prefix,
                  "kms_config" : kms_config}    
    jsonString = json.dumps(dictionary, indent=4)
    return jsonString


def get_property(entity_id, property_id, entity_attributes={}):
    property = appconfig_client.get_property(property_id)
    return property.get_current_value(entity_id=entity_id, entity_attributes=entity_attributes)

def get_feature(entity_id, feature_id, entity_attributes):
    feature = appconfig_client.get_feature(feature_id)
    return feature.get_current_value(entity_id=entity_id, entity_attributes=entity_attributes)