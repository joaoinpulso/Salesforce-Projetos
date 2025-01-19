trigger DmlTriggerBulk on Account (after update) {
 List<Opportunity> OppRelacionado =
 [SELECT Id,
         Name,
         Probability
         FROM Opportunity
         WHERE AccountId IN :Trigger.new];


List<Opportunity> oppsToUpdate = new List<Opportunity>();

for (Opportunity opp : OppRelacionado) {
    if ((opp.Probability >= 50)&&(opp.Probability<100)) {
        opp.Description = 'probabity de 50 a 100 porém ajustado performance do código';
        oppsToUpdate.add(opp);
    }
}
update OppRelacionado;
}