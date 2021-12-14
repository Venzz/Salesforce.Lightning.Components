import { LightningElement, api } from 'lwc';

export default class ComponentModalDialog extends LightningElement {
    visible = false;
    askAsyncResolve = null;

    @api header;
    @api actionTitle = 'Okay';
    @api maxWidth = '40rem';
    @api actionDisabled = false;
    @api action;



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

    async onActionClicked() {
        let settings = {};
        let content = this.template.querySelector('c-component-modal-dialog-content');
        content.showError(undefined);

        if (this.action) {
            let actionResult = this.action(settings);
            if (actionResult instanceof Promise) {
                content.startActionProgress();
                await actionResult;
                content.stopActionProgress();
            }
        }
        if (settings.error) {
            content.showError(settings.error);
        }
        if (!settings.preventClosing) {
            this.close();
        }
        this.dispatchEvent(new CustomEvent('action'));
        if (this.askAsyncResolve) {
            this.askAsyncResolve('result: action button clicked.');
            this.askAsyncResolve = null;
        }
    }

    onCancelClicked() {
        this.close();
        this.dispatchEvent(new CustomEvent('cancel'));
        if (this.askAsyncResolve) {
            this.askAsyncResolve(null);
            this.askAsyncResolve = null;
        }
    }

    get style() {
        return `max-width: ${this.maxWidth}`;
    }
}