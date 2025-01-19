public class AccountTriggerHandler {
    
   public void beforeInsert(List<Account> newAccounts) {
        //ValidatorCPF.validateAccounts(newAccounts);
    }

    /*public void beforeUpdate(List<Account> oldAccounts) {
       // ValidatorCPF.validateAccounts (oldAccounts);
        
    }*/

    public void beforeDelete(List<Account> oldAccounts) {
        try {
            // Passa a lista recebida no método para a classe que realiza a validação
            bloqueiaDeleteContaComOppVinculada.bloqueiaDelete(oldAccounts);
        } catch (Exception e) {
            // Adiciona a mensagem de erro para cada conta que está sendo excluída
            for (Account acc : oldAccounts) {
                acc.addError('Não é possível excluir esta conta: ' + e.getMessage());
            }
        }
    }    

    public void afterInsert(List<Account> newconta) {
     
    }

    public void afterUpdate(List<Account> newAccounts, Map<Id, Account> mapAccounts) {
        AccountDomain.atualizarDepartamentoDoContato(newAccounts, mapAccounts);
    }
    

    public void afterDelete(List<Account> newconta) {
      
    }

    public void afterUndelete(List<Account> newconta) {
       
    }

}