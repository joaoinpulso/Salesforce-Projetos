@IsTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2042';

    @IsTest
    static void testScheduledJob() {
        // Inserindo 200 Leads com LeadSource nulo
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i <200; i++) {
            leads.add(new Lead(
                LastName = 'Lead ' + i,
                Company = 'Company ' + i,
                Status = 'Open - Not Contacted'
            ));
        }
        insert leads;

        Test.startTest();

        // Agendar a execução da classe DailyLeadProcessor
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());

        // Executar o job agendado
        Test.stopTest();

        // Consultar os Leads e verificar se todos foram atualizados corretamente
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'Todos os leads devem ter LeadSource atualizado para Dreamforce');
    }
}