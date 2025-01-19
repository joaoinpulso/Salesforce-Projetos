public class VerificaMovie {
  
    public static void pegaMovieVerifica(List<Movie__c> movies) {

        for (Movie__c mv : movies) {
            if (mv.Diretor__c == null){
                
            mv.addError('ERROR: NÃO É POSSIVEL INCLUIR UM FILME SEM O DIRETOR');
                
            }
        }

    }
}