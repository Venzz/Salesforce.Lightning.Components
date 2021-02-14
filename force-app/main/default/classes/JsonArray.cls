public class JsonArray extends JsonValue {
    private List<JsonValue> values = new List<JsonValue>();

    // Objects -> String

    public void add(JsonValue value) {
        values.add(value);
    }

    public void add(String value) {
        values.add(JsonPrimitive.create(value));
    }

    public void add(Decimal value) {
        values.add(JsonPrimitive.create(value));
    }

    public void add(Integer value) {
        values.add(JsonPrimitive.create(value));
    }

    public void add(Boolean value) {
        values.add(JsonPrimitive.create(value));
    }
    
    // String -> Objects

    public static JsonArray parse(String input) {
        return (JsonArray)JsonValue.parse(input);
    }
    
    public static JsonArray tryParse(String input) {
        return (JsonArray)JsonValue.tryParse(input);
    }

    public JsonObject getObject(Integer index) {
        return (JsonObject)values.get(index);
    }

    public JsonArray getArray(Integer index) {
        return (JsonArray)values.get(index);
    }

    public String getString(Integer index) {
        return ((JsonPrimitive)values.get(index)).getString();
    }

    public Boolean getBoolean(Integer index) {
        return ((JsonPrimitive)values.get(index)).getBoolean();
    }

    public Integer getInteger(Integer index) {
        return ((JsonPrimitive)values.get(index)).getInteger();
    }

    public Decimal getDecimal(Integer index) {
        return ((JsonPrimitive)values.get(index)).getDecimal();
    }

    public Integer size() {
        return values.size();
    }

    // Stringify

    public String stringify() {
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