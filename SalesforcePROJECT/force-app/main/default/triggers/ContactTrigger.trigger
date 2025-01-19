trigger ContactTrigger on Contact (after insert, after update) {

    // Chama o método com os parâmetros corretos
    ContactTriggerHandler.trazerContatoParaConta((List<Contact>)Trigger.new);
}