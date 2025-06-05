global class AccessibilityProjectBilling {

    @future(callout = true)
    public static void callBillingService(String projectId, Decimal billingAmount) {
        BillingServiceProxy.InvoicesPortSoap11 stub = new BillingServiceProxy.InvoicesPortSoap11();

        //Setup username, password, billAmount, and projectId in BillingServiceProxy.project and then call billProject method
        BillingServiceProxy.project project = new BillingServiceProxy.project();
        project.projectId = projectId;
        project.billAmount = Double.valueOf(billingAmount);
        project.username = '{!$Credential.BillingServiceCredential.username}';
        project.password = '{!$Credential.BillingServiceCredential.password}';

        //If response is ok set Accessibility Project Status = Complete
        try {
            String status = stub.billProject(project);
            if (status == 'ok') {
                Accessibility_Project__c accproject = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id = :projectId LIMIT 1];
                accproject.Status__c = 'Complete';
                update accproject;
            }
        } catch (Exception e) {
            System.debug('AccessibilityProjectBilling.callBillingService: Exception: ' + e.getMessage());
        // O bloco try continua abaixo, mas não é visível na imagem.
        // Provavelmente incluiria blocos catch e/ou finally.
        }
    }
}