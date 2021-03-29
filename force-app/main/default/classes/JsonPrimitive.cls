global class JsonPrimitive extends JsonValue {
    private Object value;

    private JsonPrimitive(Object value) {
        this.value = value;
    }
    
    // Objects -> String

    global static JsonPrimitive create(Boolean input) {
        return new JsonPrimitive(input);
    }

    global static JsonPrimitive create() {
        return new JsonPrimitive(null);
    }

    global static JsonPrimitive create(Decimal input) {
        return new JsonPrimitive(input);
    }

    global static JsonPrimitive create(Integer input) {
        return new JsonPrimitive(input);
    }

    global static JsonPrimitive create(String input) {
        return new JsonPrimitive(input);
    }
    
    // String -> Objects

    global String getString() {
        return (String)value;
    }

    global Boolean getBoolean() {
        return (Boolean)value;
    }

    global Decimal getDecimal() {
        return (Decimal)value;
    }

    global Integer getInteger() {
        return (Integer)value;
    }

    global Boolean isString() {
        return value instanceof String;
    }

    // Stringify

    global override String stringify() {
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