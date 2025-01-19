import ursusResources from '@salesforce/resourceUrl/ursus_park';
import { LightningElement, api } from 'lwc';
export default class BearTile extends LightningElement {
	@api bear;
	appResources = {
		bearSilhouette: `${ursusResources}/standing-bear-silhouette.png`,
	};

    handleOpenRecordClick() {
        const selectEvent = new CustomEvent('bearview', {
            detail: this.bear.Id
        });
        this.dispatchEvent(selectEvent);
    }
}