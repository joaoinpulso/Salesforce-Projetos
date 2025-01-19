@isTest
public class LeadProcessorTest {
    @isTest
    static void testLeadProcessor() {
        // Insere 200 registros de Lead para teste
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(FirstName = 'Test', LastName = 'Lead ' + i, Company = 'Test Company'));
        }
        insert testLeads;

        // Executa o batch LeadProcessor
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Database.executeBatch(leadProcessor);
        Test.stopTest();

        // Verifica se todos os registros de Lead foram atualizados corretamente
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE Id IN :testLeads];
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'O LeadSource deve ser atualizado para Dreamforce');
        }
    }
}