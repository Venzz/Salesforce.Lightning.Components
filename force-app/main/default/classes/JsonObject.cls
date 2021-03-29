global class JsonObject extends JsonValue {
    private List<String> properties = new List<String>();
    private Map<String, JsonValue> propertyValues = new Map<String, JsonValue>();

    // Objects -> String

    global void add(String key, JsonValue value) {
        properties.add(key);
        propertyValues.put(key, value);
    }

    global void add(String key, String value) {
        properties.add(key);
        propertyValues.put(key, JsonPrimitive.create(value));
    }

    global void add(String key, Decimal value) {
        properties.add(key);
        propertyValues.put(key, JsonPrimitive.create(value));
    }

    global void add(String key, Integer value) {
        properties.add(key);
        propertyValues.put(key, JsonPrimitive.create(value));
    }

    global void add(String key, Boolean value) {
        properties.add(key);
        propertyValues.put(key, JsonPrimitive.create(value));
    }
    
    // String -> Objects
    
    global static JsonObject parse(String input) {
        return (JsonObject)JsonValue.parse(input);
    }
    
    global static JsonObject tryParse(String input) {
        return (JsonObject)JsonValue.tryParse(input);
    }

    global JsonArray getNamedArray(String name) {
        return propertyValues.containsKey(name) ? (JsonArray)propertyValues.get(name) : null;
    }

    global JsonObject getNamedObject(String name) {
        return propertyValues.containsKey(name) ? (JsonObject)propertyValues.get(name) : null;
    }

    global String getNamedString(String name) {
        return ((JsonPrimitive)propertyValues.get(name)).getString();
    }

    global Boolean getNamedBoolean(String name) {
        return ((JsonPrimitive)propertyValues.get(name)).getBoolean();
    }

    global Decimal getNamedDecimal(String name) {
        return ((JsonPrimitive)propertyValues.get(name)).getDecimal();
    }

    global Integer getNamedInteger(String name) {
        return ((JsonPrimitive)propertyValues.get(name)).getInteger();
    }

    global Boolean containsObject(String name) {
        return propertyValues.containsKey(name) && (propertyValues.get(name) instanceof JsonObject);
    }

    global Boolean containsArray(String name) {
        return propertyValues.containsKey(name) && (propertyValues.get(name) instanceof JsonArray);
    }

    global Boolean containsString(String name) {
        return propertyValues.containsKey(name) && (propertyValues.get(name) instanceof JsonPrimitive) && ((JsonPrimitive)propertyValues.get(name)).isString();
    }

    // Stringify

    global override String stringify() {
        JSONGenerator generator = JSON.createGenerator(false);
        build(generator);
        return generator.getAsString();
    }

    protected override void build(JsonGenerator jsonGenerator) {
        jsonGenerator.writeStartObject();
        for (String key : properties) {
            jsonGenerator.writeFieldName(key);
            Object value = propertyValues.get(key);
            ((JsonValue)value).build(jsonGenerator);
        }
        jsonGenerator.writeEndObject();
    }
}