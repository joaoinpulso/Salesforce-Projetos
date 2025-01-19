trigger AddOpp on Account (after insert, after update) {

    List<Opportunity> oppList = new List<Opportunity>();
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    List<Account> toProcess = null;
    switch on Trigger.operationType {
        when AFTER_INSERT {
        // All inserted Accounts will need the Opportunity, so there is no need to perform the query
            toProcess = Trigger.New;
        }
        when AFTER_UPDATE {
            toProcess = [SELECT Id,Name FROM Account
                         WHERE Id IN :Trigger.New AND
                         Id NOT IN (SELECT AccountId FROM Opportunity WHERE AccountId in :Trigger.New)];
        }
    }
    for (Account a : toProcess) {
        // Add a default opportunity for this account
        oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                    StageName='Prospecting',
                                    CloseDate=System.today().addMonths(1),
                                    AccountId=a.Id));
    }
    if (oppList.size() > 0) {
        insert oppList;
    }
    /* List<Opportunity> oppList = new List<Opportunity>();
    // Get the related opportunities for the accounts in this trigger
    Map<Id,Account> acctsWithOpps = new Map<Id,Account>(
        [SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :Trigger.new]);
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate through each account.
    for(Account a : Trigger.new) {
        System.debug('acctsWithOpps.get(a.Id).Opportunities.size()=' + acctsWithOpps.get(a.Id).Opportunities.size());
        // Check if the account already has a related opportunity.
        if (acctsWithOpps.get(a.Id).Opportunities.size() == 0) {
            // If it doesn't, add a default opportunity
            oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=a.Id));
        }
    }
    if (oppList.size() > 0) {
        insert oppList;
    }

}
Esse acionador adiciona uma oportunidade relacionada para cada conta nova ou 
atualizada caso nenhuma oportunidade já esteja associada à conta. O acionador 
primeiramente realiza uma consulta SOQL para obter todas as oportunidades filho 
das contas que o acionador disparou. Em seguida, o acionador itera sobre a lista de 
sObjects em Trigger.new para obter o sObject de cada conta. Se a conta não tem nenhum 
sObject de oportunidade relacionado, o loop for cria um. Se o acionador criou alguma nova 
oportunidade, a instrução final faz a inserção. */

}