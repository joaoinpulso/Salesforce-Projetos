trigger ContextExampleTrigger on Account (before insert, after insert, after delete) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            // Process before insert
        } else if (Trigger.isAfter) {
            // Process after insert
        }
    }
    else if (Trigger.isDelete) {
        // Process after delete
    }
}

/*Algumas outras variáveis ​​de contexto exibem um valor booleano para indicar se o acionador
 foi disparado devido a uma atualização ou a algum outro evento. Essas variáveis ​​são úteis 
 quando um acionador combina diversos eventos. Por exemplo:*/