public class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        try {

            // Verifica se o nome da conta não está vazio
            if (accountName == null || String.isBlank(accountName)) {
              
                // Retorna null se o nome for vazio
                return null;
                
            }

            // Cria uma nova instância de Account
            Account acct = new Account(Name = accountName);

            // Tenta inserir a conta no sistema
            insert acct;

            // Retorna o registro da conta se inserido com sucesso
            return acct;

        } catch (DmlException e) {

            // Se ocorrer uma exceção DML, retorna null
            return null;
        }
    }
}