import Contact_OBJECT from '@salesforce/schema/Contact';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { LightningElement } from 'lwc';
export default class ContactCreator extends LightningElement {
    objectApiName = Contact_OBJECT;
    fields = [ FIRSTNAME_FIELD,LASTNAME_FIELD, EMAIL_FIELD];
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}