public class MovieTriggerHandler {
    
    public void beforeInsert(List<Movie__c> newMovies) {
        VerificaMovie.pegaMovieVerifica(Trigger.new);
       
    }

    public void beforeUpdate(List<Movie__c> newMovies, Map<Id, Movie__c> oldMoviesMap) {
        // Lógica para execução antes da atualização
        for (Movie__c mv : newMovies) {
            Movie__c oldmv = oldMoviesMap.get(mv.Id);
            
          
        }
    }

    public void beforeDelete(List<Movie__c> oldMovies) {
        // Lógica para execução antes da exclusão
        for (Movie__c mv : oldMovies) {
            
          
        }
    }

    public void afterInsert(List<Movie__c> newMovies) {
        // Lógica para execução após a inserção
        for (Movie__c mv : newMovies) {
           
        }
    }

    public void afterUpdate(List<Movie__c> newMovies, Map<Id, Movie__c> oldMoviesMap) {
        // Lógica para execução após a atualização
        for (Movie__c mv : newMovies) {
            Movie__c oldmv = oldMoviesMap.get(mv.Id);
            
        }
    }

    public void afterDelete(List<Movie__c> oldMovies) {
        // Lógica para execução após a exclusão
        for (Movie__c mv : oldMovies) {
            // Exemplo: Registrar exclusão
            System.debug('Conta excluída: ' + mv.Id);
        }
    }

    public void afterUndelete(List<Movie__c> restoredMovies) {
        for (Movie__c mv : restoredMovies) {
            
            update mv;
        }
    }
}