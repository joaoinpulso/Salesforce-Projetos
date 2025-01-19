public class Accountpage {
    public Account account { get; set; }
    public List<Account> accounts { get; set; }

    public Accountpage() {
        account = new Account();
        loadAccounts();
    }

    public void loadAccounts() {
        accounts = [SELECT Id, Name, Phone, Industry, Rating, Website, BillingCity FROM Account];
    }

    public PageReference save() {
        
         if (String.isBlank(Account.Website)){ 
             
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'WEBSITE OBRIGATÓRIO.'));
            return null;  // Permanece na mesma página
               
                
            }
        
        try {
            insert account;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Conta salva com sucesso.'));
            account = new Account();  // Limpar o formulário
            loadAccounts();  // Recarregar a lista de contas
            return null;  // Permanece na mesma página
            
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Erro ao salvar a conta: ' + e.getMessage()));
            return null;  // Permanece na mesma página
        }
    }

    public PageReference cancel() {
        account = new Account();
        return null;  // Permanece na mesma página
    }

  

}