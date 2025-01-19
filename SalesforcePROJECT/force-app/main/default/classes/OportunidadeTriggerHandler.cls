public with sharing class OportunidadeTriggerHandler {
    public static void preencherCPF_PADRAONaConta(List<Opportunity> newOpp, Map<Id, Opportunity> oldOpp) {
        Set<Id> oppIds = new Set<Id>();
        Set<Id> oppDesvincular = new Set<Id>();
        Set<Id> contaIds = new Set<Id>();
        List<Account> contasParaAtualizar = new List<Account>();
        Set<String> statusParaDesvincular = new Set<String>{
            'Prospecting', 'Qualification', 'Needs Analysis'
        };
    
        // Coleta os AccountIds de todas as oportunidades no loop inicial
        for (Opportunity opp : newOpp) {
            contaIds.add(opp.AccountId);
        }
    
        // Consulta em massa todas as contas associadas às oportunidades
        Map<Id, Account> contasMap = new Map<Id, Account>(
            [SELECT Id, CPF__c FROM Account WHERE Id IN :contaIds]
        );
    
        // Processa as oportunidades usando as contas já consultadas
        for (Opportunity opp : newOpp) {
            if (isChanged(opp, new Set<String> {'StageName'}) 
                && oldOpp.get(opp.Id).StageName == 'Value Proposition' 
                && opp.StageName == 'Id. Decision Makers') {
                oppIds.add(opp.Id);
    
            } else if (isChanged(opp, new Set<String> {'StageName'}) 
                    && statusParaDesvincular.contains(opp.StageName) 
                    && opp.AccountId != null 
                    && contasMap.containsKey(opp.AccountId) 
                    && contasMap.get(opp.AccountId).CPF__c != null) {
                oppDesvincular.add(opp.Id);
            }
        }
    
        // Atualiza as contas com CPF padrão
        if (!oppIds.isEmpty()) {
            for (Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE Id IN :oppIds]) {
                contasParaAtualizar.add(
                    new Account(
                        Id = opp.AccountId,
                        CPF__c = '23753283886'
                    )
                );
            }
    
            if (!contasParaAtualizar.isEmpty()) {
                update contasParaAtualizar;
            }
        }
    
        // Atualiza as contas para desvincular CPF
        if (!oppDesvincular.isEmpty()) {
            for (Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE Id IN :oppDesvincular]) {
                contasParaAtualizar.add(
                    new Account(
                        Id = opp.AccountId,
                        CPF__c = null
                    )
                );  
            }
    
            if (!contasParaAtualizar.isEmpty()) {
                update contasParaAtualizar;
            }
        }
    }
    
        private static Boolean isChanged(SObject objeto, Set<String> fieldSet) {
            SObject objetoOld = Trigger.isUpdate ? Trigger.oldMap.get(objeto.Id) : null;

            for (String campo : fieldSet) {
                if ((Trigger.isInsert || (Trigger.isUpdate && objeto.get(campo) != objetoOld.get(campo)))) {
                    return true;
                }
            }

            return false;
        }
}