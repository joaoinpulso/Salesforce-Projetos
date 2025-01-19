trigger ContactDeletion on Contact (before delete) {

    for (Contact c : [SELECT Id FROM Contact WHERE Id IN (
                      SELECT Diretor__c FROM Movie__c)
                       AND Id IN :Trigger.old]){

            Trigger.oldMap.get(c.Id).addError('ERROR: NÃO É POSSIVEL DELETAR UM CONTACT ONDE EXISTE UM MOVIE VINCULADO');

                            

    } 

}