@IsTest
public class JsonTest {
    @IsTest static void createsEmptyJsonObject() {
        JsonObject jsonObject = new JsonObject();
        System.assertEquals('{}', jsonObject.stringify());
    }

    @IsTest static void createsEmptyJsonArray() {
        JsonArray jsonArray = new JsonArray();
        System.assertEquals('[]', jsonArray.stringify());
    }

    @IsTest static void createsJsonPrimitive() {
        JsonPrimitive primitive = JsonPrimitive.create(2147483648.1337);
        System.assertEquals('2147483648.1337', primitive.stringify());
    }

    @IsTest static void createsJsonObjectWithProperty() {
        JsonObject jsonObject = new JsonObject();
        JsonObject.add('key', 'value');
        System.assertEquals('{"key":"value"}', jsonObject.stringify());
    }

    @IsTest static void createsJsonObjectWithSeveralProperties() {
        JsonObject jsonObject = new JsonObject();
        JsonObject.add('key', 'value');
        JsonObject.add('key1', 'value1');
        System.assertEquals('{"key":"value","key1":"value1"}', jsonObject.stringify());
    }

    @IsTest static void createsJsonObjectWithInnerObject() {
        JsonObject jsonObject = new JsonObject();
        JsonObject.add('key', 'value');
        JsonObject jsonObject1 = new JsonObject();
        jsonObject1.add('key', 'value');
        JsonObject.add('key1', jsonObject1);
        System.assertEquals('{"key":"value","key1":{"key":"value"}}', jsonObject.stringify());
    }

    @IsTest static void createsArraysInJsonObject() {
        JsonObject jsonObject = new JsonObject();
        JsonObject.add('name', 'John');
        JsonObject.add('age', '30');
        JsonArray jsonArray = new JsonArray();
        jsonArray.add('Ford');
        jsonArray.add('BMW');
        jsonArray.add('Fiat');
        JsonObject.add('cars', jsonArray);
        System.assertEquals('{"name":"John","age":"30","cars":["Ford","BMW","Fiat"]}', jsonObject.stringify());
    }

    @IsTest static void createsJsonObjectWithDifferentInnerObjects() {
        JsonObject jsonObject = new JsonObject();
        JsonObject.add('name', 'John');
        JsonArray jsonArray1 = new JsonArray();
        jsonArray1.add('30');
        jsonArray1.add(new JsonObject());
        JsonObject.add('age', jsonArray1);
        JsonArray jsonArray = new JsonArray();
        jsonArray.add('Fiat');
        jsonArray.add('BMW');
        JsonObject jsonObject1 = new JsonObject();
        jsonObject1.add('color', 'red');
        jsonArray.add(jsonObject1);
        JsonObject.add('cars', jsonArray);
        System.assertEquals('{"name":"John","age":["30",{}],"cars":["Fiat","BMW",{"color":"red"}]}', jsonObject.stringify());
    }

    @IsTest static void createsJsonObjectWithDifferentInnerObjectsAndDifferentPrimitiveType() {
        JsonObject jsonObject = new JsonObject();
        JsonObject.add('name', 'Jim');
        JsonObject.add('hat', JsonPrimitive.create());
        JsonObject.add('age', 18);
        JsonObject.add('hasCars', true);
        JsonObject.add('bitcoins', 0.1234599);
        JsonArray jsonArray = new JsonArray();
        jsonArray.add(new JsonObject());
        JsonObject jsonObject1 = new JsonObject();
        jsonObject1.add('years', 20);
        jsonObject1.add('stop', false);
        jsonObject1.add('color', 'red');
        jsonArray.add(jsonObject1);
        jsonArray.add(2.2);
        jsonArray.add(2);
        jsonArray.add(false);
        jsonObject.add('cars', jsonArray);
        System.assertEquals('{"name":"Jim","hat":null,"age":18,"hasCars":true,"bitcoins":0.1234599,"cars":[{},{"years":20,"stop":false,"color":"red"},2.2,2,false]}', jsonObject.stringify());
    }

    @IsTest static void parsesJsonObject() {
        String response = '{"key": "value", "key2": 0.02, "key3": true, "key4": 100}';
        JsonObject jsonObj = JsonObject.parse(response);
        System.assertEquals('value', jsonObj.getNamedString('key'));
        System.assertEquals(0.02, jsonObj.getNamedDecimal('key2'));
        System.assertEquals(true, jsonObj.getNamedBoolean('key3'));
        System.assertEquals(100, jsonObj.getNamedInteger('key4'));
    }

    @IsTest static void parsesJsonArray() {
        String response = '["Ford",100,true]';
        JsonArray jsonArr = JsonArray.parse(response);
        System.assertEquals(3, jsonArr.size());
        System.assertEquals('Ford', jsonArr.getString(0));
        System.assertEquals(100, jsonArr.getInteger(1));
        System.assertEquals(true, jsonArr.getBoolean(2));
    }

    @IsTest static void parsesJsonArrayWithInnerArray() {
        String response = '[["key1", 0.01,false], 100, true]';
        JsonArray jsonArr = JsonArray.parse(response);
        JsonArray innerJsonArray = jsonArr.getArray(0);
        System.assertEquals('key1', innerJsonArray.getString(0));
        System.assertEquals(0.01, innerJsonArray.getDecimal(1));
        System.assertEquals(false, innerJsonArray.getBoolean(2));
        System.assertEquals(100, jsonArr.getInteger(1));
        System.assertEquals(true, jsonArr.getBoolean(2));
    }

    @IsTest static void parsesJsonObjectWithInnerObject() {
        String response = '{"key": "value", "obj": {"key": true, "key3": 10.0}}';
        JsonObject jsonObj = JsonObject.parse(response);
        System.assertEquals('value', jsonObj.getNamedString('key'));
        JsonObject innerJsonObject = jsonObj.getNamedObject('obj');
        System.assertEquals(true, innerJsonObject.getNamedBoolean('key'));
        System.assertEquals(10.0, innerJsonObject.getNamedDecimal('key3'));
    }

    @IsTest static void parsesJson() {
        String response = '[[{"key": 0.01,"key3": null,"key1":"123AM"}],{"PKT": 0.02,"CODE":"123AM"},{"key": 0.11,"CODE":[1223, true]}]';
        JsonArray jsonArr = JsonArray.parse(response);
        JsonArray innerJsonArray = jsonArr.getArray(0);
        JsonObject innerJsonObject = innerJsonArray.getObject(0);
        System.assertEquals(0.01, innerJsonObject.getNamedDecimal('key'));
        System.assertEquals('123AM', innerJsonObject.getNamedString('key1'));
        System.assertEquals(null, innerJsonObject.getNamedInteger('key3'));
        innerJsonObject = jsonArr.getObject(1);
        System.assertEquals(0.02, innerJsonObject.getNamedDecimal('PKT'));
        System.assertEquals('123AM', innerJsonObject.getNamedString('CODE'));
        innerJsonObject = jsonArr.getObject(2);
        System.assertEquals(0.11, innerJsonObject.getNamedDecimal('key'));
        innerJsonArray = innerJsonObject.getNamedArray('CODE');
        System.assertEquals(1223, innerJsonArray.getInteger(0));
        System.assertEquals(true, innerJsonArray.getBoolean(1));
    }

    @IsTest static void returnsTrueForContainsObjectIfObjectContainsNamedObject() {
        JsonObject inputObject = JsonObject.parse('{"Property": { }}');
        System.assertEquals(true, inputObject.containsObject('Property'));
    }

    @IsTest static void returnsFalseForContainsObjectIfObjectContainsNamedDecimal() {
        JsonObject inputObject = JsonObject.parse('{"Property": 0.02}');
        System.assertEquals(false, inputObject.containsObject('Property'));
    }

    @IsTest static void returnsTrueForContainsArrayIfObjectContainsNamedArray() {
        JsonObject inputObject = JsonObject.parse('{"Property": []}');
        System.assertEquals(true, inputObject.containsArray('Property'));
    }

    @IsTest static void returnsFalseForContainsArrayIfObjectContainsNamedObject() {
        JsonObject inputObject = JsonObject.parse('{"Property": { }}');
        System.assertEquals(false, inputObject.containsArray('Property'));
    }

    @IsTest static void returnsTrueForContainsStringIfObjectContainsNamedString() {
        JsonObject inputObject = JsonObject.parse('{"Property": "test"}');
        System.assertEquals(true, inputObject.containsString('Property'));
    }

    @IsTest static void returnsFalseForContainsStringIfObjectContainsNamedDecimal() {
        JsonObject inputObject = JsonObject.parse('{"Property": 0.02}');
        System.assertEquals(false, inputObject.containsString('Property'));
    }

    @IsTest static void returnsNullIfParserIsUnableToParseInputString() {
        JsonObject inputObject = JsonObject.tryParse('{"Property: 0.02}');
        System.assertEquals(null, inputObject);
        JsonArray inputArray = JsonArray.tryParse('{"Property: 0.02}');
        System.assertEquals(null, inputArray);
    }

    @IsTest static void returnsNullIfParserIsUnableToFindValue() {
        JsonObject inputObject = JsonObject.parse('{"Property": 0.02}');
        System.assertEquals(null, inputObject.getNamedObject('address'));
        System.assertEquals(null, inputObject.getNamedArray('address'));
        System.assertEquals(null, inputObject.getNamedString('address'));
        System.assertEquals(null, inputObject.getNamedBoolean('address'));
        System.assertEquals(null, inputObject.getNamedDecimal('address'));
        System.assertEquals(null, inputObject.getNamedInteger('address'));
    }

    @IsTest static void throwsExceptionIfParserIsUnableToGetValueByIndex() {
        JsonArray inputArray = JsonArray.parse('[]');

        try {
            inputArray.getObject(1);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals('List index out of bounds: 1', error.getMessage());
        }
        try {
            inputArray.getArray(1);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals('List index out of bounds: 1', error.getMessage());
        }
        try {
            inputArray.getString(1);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals('List index out of bounds: 1', error.getMessage());
        }
        try {
            inputArray.getBoolean(1);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals('List index out of bounds: 1', error.getMessage());
        }
        try {
            inputArray.getDecimal(1);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals('List index out of bounds: 1', error.getMessage());
        }
        try {
            inputArray.getInteger(1);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals('List index out of bounds: 1', error.getMessage());
        }
    }

    @IsTest static void throwsExceptionIfParserIsUnableToIdentifyValue() {
        JsonObject inputObject = JsonObject.parse('{"Property": 0.02}');
        try {
            inputObject.getNamedObject('Property');
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputObject.getNamedArray('Property');
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputObject.getNamedString('Property');
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputObject.getNamedBoolean('Property');
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            JsonObject.parse('{"Property": "1"}').getNamedDecimal('Property');
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputObject.getNamedInteger('Property');
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }

        JsonArray inputArray = JsonArray.parse('[0.02]');
        try {
            inputArray.getObject(0);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputArray.getArray(0);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputArray.getString(0);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputArray.getBoolean(0);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            JsonArray.parse('["1"]').getDecimal(0);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
        try {
            inputArray.getInteger(0);
            System.assert(false);
        } catch (Exception error) {
            System.assertEquals(true, error.getMessage().contains('Invalid conversion from runtime type'));
        }
    }
}