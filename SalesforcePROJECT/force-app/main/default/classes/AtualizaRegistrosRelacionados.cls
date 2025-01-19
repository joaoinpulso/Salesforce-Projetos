public with sharing class AtualizaRegistrosRelacionados {
    public AtualizaRegistrosRelacionados() {

        // Consulta o contato que foi associado a uma conta.
        Contact queriedContact = [SELECT Account.Name 
                                  FROM Contact
                                  WHERE FirstName = 'João Dantas' AND LastName = 'de Menezes'
                                  LIMIT 1];

        //Atualiza o número de telefone do contato
        queriedContact.Phone = '(415).555.1213';
        
        // Atualizar o setor de contas relacionado
        queriedContact.Account.Industry = 'Technology';

        // Faz duas chamadas separadas 
        // 1. Esta chamada é para atualizar o telefone do contato.
        update queriedContact;

        // 2. Esta chamada é para atualizar o setor de contas relacionado.
        update queriedContact.Account;
    }
}