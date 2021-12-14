import { LightningElement, api } from 'lwc';

export default class ComponentModalDialogContent extends LightningElement {
    actionProgressIndicator = false;
    actionProgressMessage;
    errorMessage;

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
        this.actionProgressMessage = null;
    }

    @api notifyActionProgress(message) {
        this.actionProgressMessage = message;
    }

    onCancelClicked() {
        this.dispatchEvent(new CustomEvent('cancel'));
    }

    get isActionDisabled() {
        return this.actionProgressIndicator || this.actionDisabled;
    }

    get isActionProgressMessageVisible() {
        return this.actionProgressMessage && this.actionProgressIndicator;
    }

    get displayError() {
        return this.errorMessage;
    }

    onErrorClosed() {
        this.errorMessage = null;
    }

    @api showError(error) {
        if (error instanceof String) {
            this.errorMessage = message;
        } else {
            this.errorMessage = JSON.stringify(error);
        }
    }
}