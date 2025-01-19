public with sharing class bloqueiaDeleteContaComOppVinculada {
    public static void bloqueiaDelete(List<Account> newAccounts) {
        Set<Id> accountIdsWithOpportunities = new Set<Id>();
    
        // Consulta todas as contas com oportunidades vinculadas
        for (Opportunity opp : [SELECT AccountId FROM Opportunity WHERE AccountId IN :newAccounts]) {
            accountIdsWithOpportunities.add(opp.AccountId);
        }
    
        // Adiciona erro às contas com oportunidades vinculadas
        for (Account acc : newAccounts) {
            if (accountIdsWithOpportunities.contains(acc.Id)) {
                acc.addError(System.Label.ErroContaOppVinculada);
            }
        }
    }
    
    

}