public with sharing class AccountinsertTRY {
    public static List<Account> getAllActiveAccounts() {
      return [SELECT Id, Name, Active__c FROM Account WHERE Active__c = 'Yes' WITH SECURITY_ENFORCED];
}


            public static void condicoesConta() {
            // Criar e inserir uma conta válida
            Account acct = new Account();
            acct.Name = 'Acme';  // Nome obrigatório fornecido
            acct.Phone = '(415)555-1212';
            acct.NumberOfEmployees = 100;
            acct.CPF__c = '23753283886';
            insert acct;  // Inserir a conta no Salesforce
            ID acctID = acct.Id;
            System.debug('Inseriu o registro: ' + acctID);

            try {
                // Isso causaria uma exceção se o campo Nome não fosse fornecido, então corrigimos isso
                Account acc = new Account();
                acc.Name = 'Empresa Teste';  // Nome obrigatório fornecido

                // Inserir a conta
                insert acc;
                System.debug('Inseriu a segunda conta: ' + acc.Id);
                
            } catch (DmlException e) {
                System.debug('Ocorreu uma exceção DML: ' + e.getMessage());
            }
        }

}