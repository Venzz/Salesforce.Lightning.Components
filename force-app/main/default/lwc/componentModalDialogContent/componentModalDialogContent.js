import { LightningElement, api } from 'lwc';

export default class ComponentModalDialogContent extends LightningElement {
    actionProgressIndicator = false;

    @api header;
    @api actionTitle = 'Save';
    @api cancelTitle = 'Cancel';
    @api actionDisabled = false;



    get isHeaderEmpty() {
        return !this.header || /^\s*$/.test(this.header);
    }

    onActionClicked() {
        this.dispatchEvent(new CustomEvent('action'));
    }

    @api startActionProgress() {
        this.actionProgressIndicator = true;
    }

    @api stopActionProgress() {
        this.actionProgressIndicator = false;
    }

    onCancelClicked() {
        this.dispatchEvent(new CustomEvent('cancel'));
    }

    get isActionDisabled() {
        return this.actionProgressIndicator || this.actionDisabled;
    }
}