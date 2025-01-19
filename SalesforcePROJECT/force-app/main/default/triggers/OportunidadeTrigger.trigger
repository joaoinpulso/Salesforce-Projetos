trigger OportunidadeTrigger on Opportunity (after update) {

    Boolean bypass = false;
    if(!bypass == true){
        OportunidadeTriggerHandler.preencherCPF_PADRAONaConta((List<Opportunity>)Trigger.new, (Map<Id, Opportunity>)Trigger.oldMap);
    }
}