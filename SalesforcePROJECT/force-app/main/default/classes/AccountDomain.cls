public with sharing class AccountDomain {
    public static void atualizarDepartamentoDoContato(List<Account> newAccounts, Map<Id, Account> mapAccounts) {
        // Conjunto para armazenar IDs de contas cujo campo Site foi preenchido
        Set<Id> accountIds = new Set<Id>();
    
        // Itera pelas contas e armazena as IDs das que têm Site preenchido
        for (Account acc : newAccounts) {
            if (acc.Site != null) {
                accountIds.add(acc.Id);
            }
        }
    
        // Consulta contatos relacionados às contas
        if (!accountIds.isEmpty()) {
            List<Contact> contactsToUpdate = new List<Contact>();
            List<Contact> relatedContacts = [SELECT Id, AccountId, Department FROM Contact WHERE AccountId IN :accountIds];
        
            // Atualiza o campo Department dos contatos
            for (Contact ct : relatedContacts) {
                // Aqui usamos o mapAccounts para buscar a conta pelo ID
                Account acc = mapAccounts.get(ct.AccountId);
                if (acc != null && acc.Site != null) {
                    ct.Department = acc.Site;
                    contactsToUpdate.add(ct);
                }
            }
            // Realiza o DML de forma eficiente
            if (!contactsToUpdate.isEmpty()) {
                update contactsToUpdate;
            }
        }
    }

    private static Boolean isChanged(SObject objeto, Set<String> fieldSet) {
		SObject objetoOld = Trigger.isUpdate ? Trigger.oldMap.get(objeto.Id) : null;

		for (String campo : fieldSet) {
			if ((Trigger.isInsert || (Trigger.isUpdate && objeto.get(campo) != objetoOld.get(campo)))) {
				return true;
			}
		}

		return false;
	}
}