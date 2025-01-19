public with sharing class MovieController {

    // Método estático para ser chamado por um botão ou outro mecanismo
    @AuraEnabled
    public static void updateOrInsertMovie() {

        // Consulta SOQL para buscar o filme "Toy Story"
        List<Movie__c> mov = [SELECT Id, Name FROM Movie__c WHERE Name = 'Toy Story' LIMIT 1];
        
        // Verifica se o filme foi encontrado
        if (!mov.isEmpty()) {
            Movie__c mm = mov[0]; // Pega o primeiro registro encontrado
            
            // Atualiza o nome para "Toy Story 2"
            mm.Name = 'Toy Story 2';
            update mm;
            System.debug('Atualizou o registro: ' + mm.Id);
            
        } else {
            // Insere um novo filme se "Toy Story" não foi encontrado
            Movie__c newMovie = new Movie__c(
                Name = 'Toy Story 10'
            );
            insert newMovie;
            System.debug('Inseriu o registro: ' + newMovie.Id);
        }
    }
}