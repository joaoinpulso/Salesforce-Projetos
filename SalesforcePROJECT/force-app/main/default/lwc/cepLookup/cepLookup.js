import getCepData from '@salesforce/apex/CepService.getCepData';
import { LightningElement, track } from 'lwc';

export default class CepLookup extends LightningElement {
    @track address = {};
    @track addressFound = false;
    @track error = '';

    handleCepChange(event) {
        const cep = event.target.value;

        // Valida se o CEP tem 8 dígitos e só números
        if (cep.length === 8 && /^[0-9]+$/.test(cep)) {
            this.error = '';
            getCepData({ cep })
            .then((data) => {
                this.address = data;
                this.addressFound = true;
                this.error = ''; // Limpa erros anteriores
            })
            .catch((err) => {
                this.addressFound = false;
                this.error = err.body ? err.body.message : 'Erro inesperado.';
                console.error('Erro:', err);
            });
        
        } else if (cep.length === 8) {
            this.addressFound = false;
            this.error = 'O CEP deve conter apenas números.';
        }
    }
}