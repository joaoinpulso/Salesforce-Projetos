public with sharing class AccountControllerLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
            throw new AuraHandledException('Forced error');
        
       /* return [
            SELECT Name, AnnualRevenue, Industry
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];*/
    }
}