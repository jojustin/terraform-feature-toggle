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