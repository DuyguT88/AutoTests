import json

def get_reference_json(reference_schema_path):
    json_file = open(reference_schema_path)
    data = json.load(json_file)
    print(data)
    return data