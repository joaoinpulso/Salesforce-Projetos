import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import { LightningElement, api, wire } from 'lwc';
export default class WireGetRecord extends LightningElement {
    @api recordId;
    data;
    error;
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD] })
    wiredAccount({data, error}) {
        console.log('Execute logic each time a new value is provisioned');
        if (data) {
            this.data = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }
    get name() {
        return getFieldValue(this.data, ACCOUNT_NAME_FIELD);
    }
}