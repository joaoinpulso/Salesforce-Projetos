@isTest
public class AddPrimaryContactTest {
    @isTest
    static void testAddPrimaryContact() {
        // Criar 50 contas para NY e 50 para CA
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'Account NY ' + i, BillingState = 'NY'));
            accounts.add(new Account(Name = 'Account CA ' + i, BillingState = 'CA'));
        }
        insert accounts;

        // Criar um contato de exemplo
        Contact exampleContact = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'john.doe@example.com');

        // Instanciar a classe AddPrimaryContact
        AddPrimaryContact job = new AddPrimaryContact(exampleContact, 'CA');

        // Enfileirar o trabalho
        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();

        // Verificar se um contato foi inserido para cada conta com BillingState 'CA'
        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE Email = 'john.doe@example.com'];
        System.assertEquals(50, insertedContacts.size(), 'Deve haver 50 contatos inseridos para contas com BillingState CA');
    }
}