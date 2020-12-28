import { LightningElement, api } from 'lwc';

export default class ComponentModalDialog extends LightningElement {
    visible = false;
    askAsyncResolve = null;

    @api header;
    @api actionTitle = 'Okay';



    @api open() {
        this.visible = true;
    }

    @api close() {
        this.visible = false;
    }

    @api async askAsync() {
        return new Promise((resolve, reject) => {
            this.open();
            this.askAsyncResolve = resolve;
        });
    }

    onActionClicked() {
        this.visible = false;
        this.dispatchEvent(new CustomEvent('action'));
        if (this.askAsyncResolve) {
            this.askAsyncResolve('action');
            this.askAsyncResolve = null;
        }
    }

    onCancelClicked() {
        this.visible = false;
        this.dispatchEvent(new CustomEvent('cancel'));
        if (this.askAsyncResolve) {
            this.askAsyncResolve(null);
            this.askAsyncResolve = null;
        }
    }
}