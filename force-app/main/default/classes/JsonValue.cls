public abstract class JsonValue {
    protected abstract void build(JsonGenerator jsonGenerator);

    public static JsonValue tryParse(String input) {
        try {
            return parse(input);
        } catch (Exception error) {
            return null;
        }
    }

    public static JsonValue parse(String input) {
        Object deserializedInput = JSON.deserializeUntyped(input);
        return parse(deserializedInput);
    }

    private static JsonValue parse(Object deserializedInput) {
        if (deserializedInput == null) {
            return JsonPrimitive.create();
        } else if (deserializedInput instanceof List<Object>) {
            JsonArray jsonArray = new JsonArray();
            for (Object arrayItem : (List<Object>)deserializedInput) {
                jsonArray.add(JsonValue.parse(arrayItem));
            }
            return jsonArray;
        } else if (deserializedInput instanceof Map<String, Object>) {
            JsonObject jsonObject = new JsonObject();
            for (String propertyName : ((Map<String, Object>)deserializedInput).keySet()) {
                jsonObject.add(propertyName, JsonValue.parse(((Map<String, Object>)deserializedInput).get(propertyName)));
            }
            return jsonObject;
        } else if (deserializedInput instanceOf String) {
            return JsonPrimitive.create((String)deserializedInput);
        } else if (deserializedInput instanceOf Integer) {
            return JsonPrimitive.create((Integer)deserializedInput);
        } else if (deserializedInput instanceOf Decimal) {
            return JsonPrimitive.create((Decimal)deserializedInput);
        } else if (deserializedInput instanceOf Boolean) {
            return JsonPrimitive.create((Boolean)deserializedInput);
        } else {
            throw new ParserException('Parsing ' + deserializedInput + ' type is not supported');
        }
    }



    private class ParserException extends Exception {
    }
}