public class AccountLC {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, AnnualRevenue FROM Account WHERE Industry != null LIMIT 50];
    }
}