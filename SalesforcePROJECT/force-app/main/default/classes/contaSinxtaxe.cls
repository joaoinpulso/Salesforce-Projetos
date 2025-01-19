public with sharing class contaSinxtaxe {
    public contaSinxtaxe() {

        List<Account> acct = [SELECT Id, Name, Phone FROM Account];
        // DUAS MANEIRAS DE CRIAR UM SOBJECT E ADICIONAR CAMPOS

        /*

        Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);

        // OUUUUUU

        Account acct = new Account();
        acct.Name = 'Acme';
        acct.Phone = '(415)555-1212';
        acct.NumberOfEmployees = 100;


         
        
        No entanto, quando você não sabe o tipo de sObject com que seu método está lidando, pode usar o tipo de dados 
        sObject geral. As variáveis declaradas com o tipo de objeto sObject geral podem referenciar qualquer registro do Salesforce, 
        seja registro de objeto padrão ou personalizado.


        Este exemplo mostra como qualquer objeto Salesforce, como uma conta ou um objeto personalizado chamado Book__c,
        pode ser atribuído a uma variável sObject geral.

        
        sObject sobj1 = new Account(Name='Trailhead');
        sObject sobj2 = new Book__c(Name='Workbook 1');


        // Cast a generic sObject to an Account
        Account acct = (Account)myGenericSObject;
        // Now, you can use the dot notation to access fields on Account
        String name = acct.Name;
        String phone = acct.Phone; 
        
        */
    }
}