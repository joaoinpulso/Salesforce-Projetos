public with sharing class ContactControllerLWC {
    @AuraEnabled(cacheable=true)
    public static List <Contact> getContacts() {
        throw new AuraHandledException('Forced error');

        
        /*return [SELECT Id, FirstName, LastName, Email 
        FROM Contact
        WITH SECURITY_ENFORCED
        ORDER BY LastName
        ];*/

    }
}