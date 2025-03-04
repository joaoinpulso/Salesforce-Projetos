public with sharing class EstruturaCondicional {
    public String inicio = 'verdadeiro';

    // Construtor
    public EstruturaCondicional() {
        this.inicio = 'falso'; // Altera o valor do atributo
    
    }

    public String mediaAluno(Integer nota1, Integer nota2) {
        if (this.inicio == 'verdadeiro') {
            if (nota1 < 0 || nota1 > 10 || nota2 < 0 || nota2 > 10) {
                return 'Erro: Digite apenas notas entre 0 e 10';
            }

            Integer media = (nota1 + nota2) / 2;

            if (media > 6 && media <= 10) {
                return 'Aprovado';
            } else if (media >= 5 && media <= 6) {
                return 'Recuperação';
            } else {
                return 'Reprovado';
            }
        }
        return 'Método não executado, início é verdadeiro';
    }
}