public with sharing class InserirRegistroRelacionados {
    public InserirRegistroRelacionados() {

        Account acct = new Account (Name = 'João Class IRegistroRelacionado', CPF__c='23753283886');
        insert acct;

        // Assim que a conta for inserida, o sObject será 
        // preenchido com um ID.
        // Obtenha este ID.
        ID acctID = acct.ID;

        // Adicione um contato a esta conta.
        Contact joao = new Contact (
            FirstName='João Dantas',
            LastName='de Menezes',
            Phone='415.555.1212',
            AccountId=acctID
        );
        insert joao;
    }
}