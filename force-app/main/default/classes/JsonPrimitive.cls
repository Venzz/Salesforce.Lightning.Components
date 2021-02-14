public class JsonPrimitive extends JsonValue {
    private Object value;

    private JsonPrimitive(Object value) {
        this.value = value;
    }
    
    // Objects -> String

    public static JsonPrimitive create(Boolean input) {
        return new JsonPrimitive(input);
    }

    public static JsonPrimitive create() {
        return new JsonPrimitive(null);
    }

    public static JsonPrimitive create(Decimal input) {
        return new JsonPrimitive(input);
    }

    public static JsonPrimitive create(Integer input) {
        return new JsonPrimitive(input);
    }

    public static JsonPrimitive create(String input) {
        return new JsonPrimitive(input);
    }
    
    // String -> Objects

    public String getString() {
        return (String)value;
    }

    public Boolean getBoolean() {
        return (Boolean)value;
    }

    public Decimal getDecimal() {
        return (Decimal)value;
    }

    public Integer getInteger() {
        return (Integer)value;
    }

    public Boolean isString() {
        return value instanceof String;
    }

    // Stringify

    public String stringify() {
        JSONGenerator generator = JSON.createGenerator(false);
        build(generator);
        return generator.getAsString();
    }

    protected override void build(JsonGenerator jsonGenerator) {
        if (value == null) {
            jsonGenerator.writeNull();
        } else if (value instanceOf String) {
            jsonGenerator.writeString((String)value);
        } else if (value instanceOf Integer) {
            jsonGenerator.writeNumber((Integer)value);
        } else if (value instanceOf Decimal) {
            jsonGenerator.writeNumber((Decimal)value);
        } else if (value instanceOf Boolean) {
            jsonGenerator.writeBoolean((Boolean)value);
        }
    }
}