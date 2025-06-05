@isTest
public class BillingCalloutServiceTest {
    @isTest
    static void TestBillingSoapCallout(){
        Accessibility_Project__c testRec = new Accessibility_Project__c();
        testRec.Amount__c = 20.00;
        Insert testRec; // Nota: "Insert" com 'I' maiúsculo é válido, mas a convenção é "insert"

        Test.startTest();
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        AccessibilityProjectBilling.callBillingService(testRec.Id, testRec.Amount__c);
        Test.stopTest();

        testRec = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id = :testRec.Id LIMIT 1];
        system.assertEquals('Complete', testRec.Status__c, 'project status should be completed'); // Nota: "system" com 's' minúsculo é válido, mas a convenção é "System"
    }
}