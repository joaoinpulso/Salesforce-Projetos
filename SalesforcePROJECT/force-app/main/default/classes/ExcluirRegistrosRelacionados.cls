public with sharing class ExcluirRegistrosRelacionados {
    public ExcluirRegistrosRelacionados() {
        /*
        
        A operação delete permite exclusões em cascata. Quando um objeto pai é excluído, 
        excluem-se automaticamente todos os registros filhos relacionados a ele que puderem 
        ser excluídos.

        Por exemplo, se você excluir a conta criada anteriormente (conta SFDC), também
        excluirá o contato relacionado a ela.

        */

        Account[] queriedAccounts = [SELECT Id FROM Account WHERE Name=''];
        delete queriedAccounts;
    }
}