## Modal Dialog Content


##### 1. Lightning Quick Action Example
aura/quickAction.cmp
```html
<aura:component implements="force:lightningQuickActionWithoutHeader, force:hasRecordId">
    <!-- To have the component properly fill all available height, set height to the same value as in quick action in Salesforce and set display style as specified -->
    <div style="margin-left: -32px; margin-top: -16px; margin-right: -32px; margin-bottom: -32px; height: 500px; display: grid;">
       <c:quickAction style="display: grid;" recordId="{!v.recordId}" onclose="{!c.onClosed}"></c:opportunityLogACall>
    </div>
</aura:component>
```
aura/quickAction.js
```javascript
({
    onClosed: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})
```
lwc/quickAction.html
```html
<template>
    <c-component-modal-dialog-content header="Example" action-title="Okay" onaction={onActionClicked} oncancel={onCancelled}>
        Hello World
    </c-component-modal-dialog-content>
</template>
```
lwc/quickAction.js
```javascript
import { LightningElement, api } from 'lwc';

export default class QuickAction extends LightningElement {
    @api recordId;

    onActionClicked() {
    }

    onCancelled() {
        this.dispatchEvent(new CustomEvent('close'));
    }
}
```
## Modal Dialog



##### 1. Example
lwc/helloWorld.cmp
```html
<aura:component>
    <c-component-modal-dialog header="Hello World" action-title="Yes" onaction={onYesPressed}>
        <span>Is there a cow level?</span>
    </c-component-modal-dialog>
	...
</aura:component>
```
lwc/helloWorld.js
```javascript
 onCancelled() {
    var dialog = this.template.querySelector('c-component-modal-dialog');
    dialog.open();
 }
 
 onYesPressed() {
    // do things
 }
```
##### 2. Async Example
lwc/helloWorld.js
```javascript
 async onCancelled() {
    var action = await this.template.querySelector('c-component-modal-dialog').askAsync();
    if (!action) {
        // cancelled
    } else {
        // action pressed
    }
 }
```

## JSON

##### 1. String --> JSON Object
Available methods
```Java
JsonValue
    static JsonValue parse(String input)
    static JsonValue tryParse(String input)

JsonObject
    static JsonObject parse(String input)
    static JsonObject tryParse(String input)
    JsonArray getNamedArray(String name)
    JsonObject getNamedObject(String name)
    String getNamedString(String name)
    Boolean getNamedBoolean(String name)
    Decimal getNamedDecimal(String name)
    Integer getNamedInteger(String name)
    Boolean containsObject(String name)
    Boolean containsArray(String name)
    Boolean containsString(String name)

JsonArray
    static JsonArray parse(String input)
    static JsonArray tryParse(String input)
    JsonObject getObject(Integer index)
    JsonArray getArray(Integer index)
    String getString(Integer index)
    Boolean getBoolean(Integer index)
    Integer getInteger(Integer index)
    Decimal getDecimal(Integer index)
    Integer size()

JsonPrimitive
    String getString()
    Boolean getBoolean()
    Decimal getDecimal()
    Integer getInteger()
    Boolean isString()
```
Examlple
```Java
String response = '{"key": "value"}';
JsonObject jsonObj = (JsonObject)JsonValue.parse(response);
System.assertEquals('value', jsonObj.getNamedString('key'));
```
##### 2. JSON Object --> String
Available methods
```javascript
JsonObject
    JsonObject()
    void add(String key, JsonValue value)
    void add(String key, String value)
    void add(String key, Decimal value)
    void add(String key, Integer value)
    void add(String key, Boolean value)
    String stringify()

JsonArray
    JsonArray()
    void add(JsonValue value)
    void add(String value)
    void add(Decimal value)
    void add(Integer value)
    void add(Boolean value)
    String stringify()

JsonPrimitive
    JsonPrimitive create(Boolean input)
    JsonPrimitive create()
    JsonPrimitive create(Decimal input)
    JsonPrimitive create(Integer input)
    JsonPrimitive create(String input)
    String stringify()
```
Examlple
```Java
JsonObject jsonObject = new JsonObject();
JsonObject.add('key', 'value');
System.assertEquals('{"key":"value"}', jsonObject.stringify());
```