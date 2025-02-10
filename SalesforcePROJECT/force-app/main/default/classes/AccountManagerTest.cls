    @isTest
    private class AccountManagerTest {
    private static testMethod void getAccountTest1() {
        Id recordId = createTestRecord();
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://wise-badger-uqqy5w-dev-ed.trailblaze.lightning.force.com/services/apexrest/Accounts/'+ recordId +'/contacts' ;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
 
    }
    // Helper method
        static Id createTestRecord() {
        // Create test record
        Account conta = new Account(Name='Test record');
        insert conta; 
        
        Contact contato = new Contact(LastName='Test', AccountId = conta.id);
        return conta.Id;
    }
}
