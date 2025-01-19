public with sharing class atribui_ID_para_variavel {
    public static void atribui_ID_para_variavel(){

         Account acct = new Account();
         acct.Name = 'Acme';
         acct.Phone = '(415)555-1212';
         acct.NumberOfEmployees = 100;
         acct.CPF__c = '23753283886';
         insert acct;
         ID acctID = acct.Id;
         System.debug('Inseriu o registro: ' + acctID);
   
    }
}