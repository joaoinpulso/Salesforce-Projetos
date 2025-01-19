trigger SoqlTriggerBulk on Account(after update) {
    // Perform SOQL query once.
    // Get the accounts and their related opportunities.
    List<Account> acctsWithOpps =
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities)
         FROM Account WHERE Id IN :Trigger.new];
    // Iterate over the returned accounts
    for(Account a : acctsWithOpps) {
        Opportunity[] relatedOpps = a.Opportunities;
        // Do some other processing
    }
}  //OUU próximo exemplo, neste exemplo abaixo ele mostra que estamos trazendo os mesmos dados porém a query é executada diretamente


/* trigger SoqlTriggerBulk on Account(after update) {
    // Perform SOQL query once.
    // Get the related opportunities for the accounts in this trigger.
    List<Opportunity> relatedOpps = [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.new];
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {
        // Do some other processing
    }
}
  

O exemplo anterior pode ser reduzido em tamanho, combinando a consulta SOQL com o loop for em uma única
 instrução: o loop for SOQL. Apresentamos outra versão deste acionador em massa que usa o loop for SOQL.

trigger SoqlTriggerBulk on Account(after update) {
    // Perform SOQL query once.
    // Get the related opportunities for the accounts in this trigger,
    // and iterate over those records.
    for(Opportunity opp : [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.new]) {
        // Do some other processing
    }
}


*/