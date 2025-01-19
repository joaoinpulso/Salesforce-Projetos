import searchByAddress from '@salesforce/apex/CepAbertoServiceIntegracao.searchByAddress';
import searchByCep from '@salesforce/apex/CepAbertoServiceIntegracao.searchByCep';
import { LightningElement, track } from 'lwc';

export default class CepAberto extends LightningElement {
    @track cep = '';
    @track estado = '';
    @track cidade = '';
    @track logradouro = '';
    @track suggestions = [];
    @track errorMessage = '';

    handleCepChange(event) {
        this.cep = event.target.value;
        if (this.cep.length > 1) {
            this.fetchCepData(this.cep);
        }
    }

    handleAddressChange(event) {
        const field = event.target.name;
        this[field] = event.target.value;
        if (this.estado && this.cidade && this.logradouro) {
            this.fetchAddressData(this.estado, this.cidade, this.logradouro);
        }
    }

    fetchCepData(cep) {
        searchByCep({ cep })
            .then((result) => {
                if (result) {
                    this.suggestions = [{
                        logradouro: result.logradouro || '',
                        bairro: result.bairro || '',
                        cidade: result.cidade && result.cidade.nome ? result.cidade.nome : '',
                        estado: result.estado && result.estado.sigla ? result.estado.sigla : ''
                    }];
                    this.estado = result.estado && result.estado.sigla ? result.estado.sigla : '';
                    this.cidade = result.cidade && result.cidade.nome ? result.cidade.nome : '';
                    this.logradouro = result.logradouro || '';
                } else {
                    this.suggestions = [];
                }
            })
            .catch((error) => {
                this.errorMessage = 'Erro ao buscar os dados. Tente novamente.';
                console.error('Error fetching CEP data:', error);
            });
    }

    fetchAddressData(estado, cidade, logradouro) {
        searchByAddress({ estado, cidade, logradouro })
            .then((result) => {
                if (result) {
                    this.suggestions = [{
                        logradouro: result.logradouro || '',
                        bairro: result.bairro || '',
                        cidade: result.cidade && result.cidade.nome ? result.cidade.nome : '',
                        estado: result.estado && result.estado.sigla ? result.estado.sigla : ''
                    }];
                } else {
                    this.suggestions = [];
                }
            })
            .catch((error) => {
                this.errorMessage = 'Erro ao buscar os dados. Tente novamente.';
                console.error('Error fetching address data:', error);
            });
    }
}