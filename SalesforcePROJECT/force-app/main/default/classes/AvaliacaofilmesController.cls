public with sharing class AvaliacaofilmesController {   

    public static void nota() {
        // Consulta SOQL para obter filmes com nota igual a null
        List<Avalia_es_de_filmes__c> filmesComNotaNula = [SELECT Id, Nota_do_filme__c FROM Avalia_es_de_filmes__c WHERE Nota_do_filme__c = null];
        
        System.debug('Total de registros com nota nula: ' + filmesComNotaNula.size());

        // Consulta SOQL para obter filmes 'Toy Story' com nota não nula
        List<Avalia_es_de_filmes__c> filmesToyStory = 
            [SELECT Id, Nota_do_filme__c FROM Avalia_es_de_filmes__c 
             WHERE Nota_do_filme__c != null AND Name = 'Toy Story'];
             
        // Itera sobre a lista e atualiza registros
        for (Avalia_es_de_filmes__c filme : filmesToyStory) {
            filme.Nota_do_filme__c = 9;
            System.debug('Id do filme atualizado: ' + filme.Id);
        }
        
        // Atualiza os registros
        if (!filmesToyStory.isEmpty()) {
            update filmesToyStory;
            System.debug('Lista Atualizada: ' + filmesToyStory);
        } else {
            System.debug('Nenhum filme "Toy Story" encontrado para atualizar.');
        }
    }
}