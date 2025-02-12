public with sharing class MaintenanceRequestHelper {
    public static void atualizaOrdensTrabalho(List<Case> newCase, Map<Id,Case> oldCase) {
        Set<Id> idsValidos = new Set<Id>();
        
        // Itera sobre as ordens de trabalho atualizadas
        for (Case c : newCase) {
            // Verifica se o caso não está fechado e se a ordem de trabalho está fechada
            if (oldCase.get(c.Id).Status != 'Closed' && c.Status == 'Closed') {
                // Verifica se o tipo é 'Reparo' ou 'Manutenção de Rotina'
                if (c.Type == 'Repair' || c.Type == 'Routine Maintenance') {
                    idsValidos.add(c.Id);
                }
            }
        }
        
        // Se houver IDs válidos, prossegue com a criação de novos casos
        if (!idsValidos.isEmpty()) {
            List<Case> novosCasos = new List<Case>();
            Map<Id,Case> casosFechadosM = new Map<Id,Case>([SELECT Id, Vehicle__c, Equipment__c, Equipment__r.Maintenance_Cycle__c, 
                                                            (SELECT Id, Equipment__c, Quantity__c FROM Equipment_Maintenance_Items__r) 
                                                            FROM Case WHERE Id IN :idsValidos]);


            Map<Id,Decimal> ciclosManutencao = new Map<ID,Decimal>();
            AggregateResult[] resultados = [SELECT Maintenance_Request__c, MIN(Equipment__r.Maintenance_Cycle__c) ciclo 
                                            FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__c IN :idsValidos 
                                            GROUP BY Maintenance_Request__c];
        
            // Armazena os ciclos de manutenção em um mapa
            for (AggregateResult ar : resultados) { 
                ciclosManutencao.put((Id) ar.get('Maintenance_Request__c'), (Decimal) ar.get('ciclo'));
            }
            
            // Cria novos casos para cada caso fechado
            for (Case cc : casosFechadosM.values()) {
                Case nc = new Case (
                    ParentId = cc.Id,
                    Status = 'New',
                    Subject = 'Manutenção de Rotina',
                    Type = 'Routine Maintenance',
                    Vehicle__c = cc.Vehicle__c,
                    Equipment__c = cc.Equipment__c,
                    Origin = 'Web',
                    Date_Reported__c = Date.Today()
                );
                
                // Define a data de vencimento com base nos ciclos de manutenção
                if (ciclosManutencao.containsKey(cc.Id)) {
                    nc.Date_Due__c = Date.today().addDays((Integer) ciclosManutencao.get(cc.Id));
                } else {
                    nc.Date_Due__c = Date.today().addDays((Integer) cc.Equipment__r.Maintenance_Cycle__c);
                }
                
                novosCasos.add(nc);
            }
            
            // Insere os novos casos
            insert novosCasos;
            
            List<Equipment_Maintenance_Item__c> wpClonados = new List<Equipment_Maintenance_Item__c>();
            // Clona os itens de manutenção de equipamentos associados aos novos casos
            for (Case nc : novosCasos) {
                for (Equipment_Maintenance_Item__c wp : casosFechadosM.get(nc.ParentId).Equipment_Maintenance_Items__r) {
                    Equipment_Maintenance_Item__c wpClone = wp.clone();
                    wpClone.Maintenance_Request__c = nc.Id;
                    wpClonados.add(wpClone);
                }
            }
            // Insere os itens de manutenção clonados
            insert wpClonados;
        }
    }
}