trigger AccountTriggerService on Account (before insert, before update) {
   
  /*      for(Account a : Trigger.new) {
            a.Description = 'New description';
            System.debug('Entrou for');

        }


    }


Este exemplo é uma versão modificada do acionador de exemplo AccountTriggerService.
 Ele itera sobre cada conta em um loop for e atualiza o campo Description
  (Descrição) de cada uma.*/
}