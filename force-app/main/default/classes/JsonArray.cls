global class JsonArray extends JsonValue {
    private List<JsonValue> values = new List<JsonValue>();

    // Objects -> String

    global void add(JsonValue value) {
        values.add(value);
    }

    global void add(String value) {
        values.add(JsonPrimitive.create(value));
    }

    global void add(Decimal value) {
        values.add(JsonPrimitive.create(value));
    }

    global void add(Integer value) {
        values.add(JsonPrimitive.create(value));
    }

    global void add(Boolean value) {
        values.add(JsonPrimitive.create(value));
    }
    
    // String -> Objects

    global static JsonArray parse(String input) {
        return (JsonArray)JsonValue.parse(input);
    }
    
    global static JsonArray tryParse(String input) {
        return (JsonArray)JsonValue.tryParse(input);
    }

    global JsonObject getObject(Integer index) {
        return (JsonObject)values.get(index);
    }

    global JsonArray getArray(Integer index) {
        return (JsonArray)values.get(index);
    }

    global String getString(Integer index) {
        return ((JsonPrimitive)values.get(index)).getString();
    }

    global Boolean getBoolean(Integer index) {
        return ((JsonPrimitive)values.get(index)).getBoolean();
    }

    global Integer getInteger(Integer index) {
        return ((JsonPrimitive)values.get(index)).getInteger();
    }

    global Decimal getDecimal(Integer index) {
        return ((JsonPrimitive)values.get(index)).getDecimal();
    }

    global Integer size() {
        return values.size();
    }

    // Stringify

    global override String stringify() {
        JSONGenerator generator = JSON.createGenerator(false);
        build(generator);
        return generator.getAsString();
    }

    protected override void build(JsonGenerator jsonGenerator) {
        jsonGenerator.writeStartArray();
        for (JsonValue value : values) {
            value.build(jsonGenerator);
        }
        jsonGenerator.writeEndArray();
    }
}