import { LightningElement } from 'lwc';

export default class TesteLWC extends LightningElement {
    show = true;
    texto = ''; // Variável texto inicializada

    handleClick() {
        this.show = !this.show;
    }

    handleChange(event) {
        this.texto = event.target.value; // Corrige o binding com this
    }
}