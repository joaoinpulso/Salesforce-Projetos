trigger DmlTriggerNotBulk on Account(after update) {
 /*List<Opportunity> OppRelacionado = [SELECT Id FROM Opportunity WHERE AccountId In :Trigger.new];
    for (Opportunity opp : OppRelacionado) {
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'Probabilidade 50 a 100';
            update opp;
        }
    
 }*/
}