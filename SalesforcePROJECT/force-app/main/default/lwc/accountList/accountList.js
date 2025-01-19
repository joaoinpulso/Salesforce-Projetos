import getAccounts from '@salesforce/apex/AccountControllerLWC.getAccounts';
import { reduceErrors } from 'c/ldsUtils';
import { LightningElement, wire } from 'lwc';


/*const COLUMNS = [
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Annual Revenue', fieldName: REVENUE_FIELD.fieldApiName, type: 'currency' },
    { label: 'Industry', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text' }
];*/
export default class AccountList extends LightningElement {
    //columns = COLUMNS;
    @wire(getAccounts)
    accounts;

    get errors() {
        return (this.accounts.error) ?
            reduceErrors(this.accounts.error) : [];
    }
}