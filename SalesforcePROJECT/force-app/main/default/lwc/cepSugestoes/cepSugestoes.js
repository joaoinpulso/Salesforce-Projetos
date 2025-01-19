import getSuggestions from '@salesforce/apex/CepAutocompleteController.getSuggestions';
import { LightningElement, track } from 'lwc';

export default class CepAutocomplete extends LightningElement {
    @track suggestions = []; // Lista de sugestões de CEP
    @track error; // Mensagem de erro

    handleInputChange(event) {
        const query = event.target.value;

        if (query && query.length >= 3) {
            // Chamando o método Apex com a entrada do usuário
            getSuggestions({ query })
                .then((data) => {
                    this.suggestions = data;
                    this.error = null; // Limpa erros anteriores
                })
                .catch((err) => {
                    this.suggestions = [];
                    this.error = 'Erro ao buscar sugestões. Tente novamente.';
                    console.error(err);
                });
        } else {
            // Limpa sugestões se o texto for apagado ou curto
            this.suggestions = [];
        }
    }

    handleSelect(event) {
        const selectedCep = event.target.textContent;
        console.log('CEP selecionado:', selectedCep);

        // Exemplo: Aqui você pode emitir um evento ou manipular o CEP selecionado
        alert('CEP selecionado: ' + selectedCep);
    }
}