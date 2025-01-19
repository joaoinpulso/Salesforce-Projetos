@isTest
private class AccountProcessorTest {

    @isTest
    static void testCountContacts() {
        
        Account acc = new Account (Name = 'TesteProcessor');
        insert acc;

        List<Contact> cts = new List<Contact> {
            new Contact (FirstName= 'ttt', LastName = 'Teste', AccountId = acc.Id),
            new Contact (FirstName= 'oioi', LastName = 'Teste2', AccountId = acc.Id)
        };

        insert cts;

        Test.startTest();
        AccountProcessor.countContacts (new List <Id> {acc.Id});
        Test.stopTest();


    }
}