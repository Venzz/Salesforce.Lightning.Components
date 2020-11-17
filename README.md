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
