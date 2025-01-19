public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT Id, Name, LeadSource
                            FROM Lead
                            WHERE LeadSource = null 
                            LIMIT 200];
        
        // Atualizar a fonte de todos os Leads na lista
        for (Lead ld : leads) {
            ld.LeadSource = 'Dreamforce';
        }
        
        // Atualização em massa fora do loop
        if (!leads.isEmpty()) {
            update leads;
        }
    }
}