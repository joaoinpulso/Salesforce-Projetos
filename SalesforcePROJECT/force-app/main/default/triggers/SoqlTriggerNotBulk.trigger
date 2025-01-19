trigger SoqlTriggerNotBulk on Account(after update) {
    for(Account a : Trigger.new) {
/*O acionador a seguir (SoqlTriggerNotBulk) mostra um padrão de consulta SOQL 
que deve ser evitado. O exemplo faz uma consulta SOQL dentro de um loop for para
 obter as oportunidades relacionadas de cada conta, que são executadas uma vez para
  o sObject de cada conta em Trigger.new. Se você tem uma grande lista de contas, uma consulta 
SOQL dentro de um loop for pode resultar em muitas consultas SOQL. 
O próximo exemplo mostra a abordagem recomendada.*/
        Opportunity[] opps = [SELECT Id,Name,CloseDate
                             FROM Opportunity WHERE AccountId=:a.Id];
    }
}