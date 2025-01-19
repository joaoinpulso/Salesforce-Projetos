/*

Crie uma classe Apex que use o Batch Apex para atualizar registros de Leads.
Crie uma classe Apex que implemente a interface Database.Batchable para atualizar todos os registros de Lead na organização com um LeadSource específico.
Crie uma classe Apex:
Nome:LeadProcessor
Interface:Database.Batchable
Use um QueryLocator no método start para coletar todos os registros de Lead na organização
O método execute deve atualizar todos os registros de Lead na organização com o valor LeadSource deDreamforce
Crie uma classe de teste Apex:
Nome:LeadProcessorTest
Na classe de teste, insira 200 registros de Lead, execute a classe LeadProcessor Batch e teste se todos os registros de Lead foram atualizados corretamente
Os testes unitários devem cobrir todas as linhas de código incluídas na classe LeadProcessor , resultando em 100% de cobertura de código
Antes de verificar este desafio, execute sua classe de teste pelo menos uma vez usando o recurso Executar tudo do console do desenvolvedor

*/

public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Coleta todos os registros de Lead na organização
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        // Atualiza o LeadSource de todos os registros de Lead para 'Dreamforce'
        List<Lead> leadsToUpdate = new List<Lead>();
        for (sObject s : scope) {
            Lead lead = (Lead)s;
            lead.LeadSource = 'Dreamforce';
            leadsToUpdate.add(lead);
        }
        // Realiza a atualização dos leads
        update leadsToUpdate;
    }

    public void finish(Database.BatchableContext bc) {
        // Método opcional para realizar ações após a conclusão do batch
    }
}