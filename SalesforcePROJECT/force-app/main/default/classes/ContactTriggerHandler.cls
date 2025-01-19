public with sharing class ContactTriggerHandler {
    public static void trazerContatoParaConta(List<Contact> newContato) {

        Set<Id> contactIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();

        for (Contact ct : newContato) {
            if (ct.AccountId != null) {
                contactIds.add(ct.Id);
                accountIds.add(ct.AccountId);
            }
        }

        if (!contactIds.isEmpty()) {
            List<Account> contaRelacionada = [SELECT Id, Contact__c FROM Account WHERE Id IN :accountIds];
            List<Contact> contatoRelacionadoConta = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds AND Id IN :contactIds];
            
            Map<Id, Account> accountMap = new Map<Id, Account>(contaRelacionada);

            for (Contact ct : contatoRelacionadoConta) {
                Account acc = accountMap.get(ct.AccountId);
                if (acc != null) {
                    acc.Contact__c = ct.Id; // Atualiza o campo Contact__c com o ID do contato
                }
            }

            // Atualiza as contas no banco de dados
            update contaRelacionada;
        }
    }
}