/*

Crie uma classe Apex que possa ser colocada em fila e que insira contatos para contas.
Crie uma classe Apex que possa ser enfileirada e que insira o mesmo contato para cada 
conta de um estado específico.

Crie uma classe Apex:
Nome:AddPrimaryContact
Interface:Queueable
Crie um construtor para a classe que aceite como primeiro argumento um Contact sObject
e um segundo argumento como uma string para a abreviação State
O executemétodo deve consultar no máximo 200 Contas com o BillingStateespecificado
pela abreviação State passada para o construtor e inserir o registro Contact sObject
associado a cada Conta. Veja o clone()método sObject.

Crie uma classe de teste Apex:
Nome:AddPrimaryContactTest
Na classe de teste, insira 50 registros de conta para BillingState NYe 50 registros
de conta paraBillingState CA
Crie uma instância da AddPrimaryContactclasse, enfileire o trabalho e assegure que
um registro de contato foi inserido para cada uma das 50 contas com o BillingStatedeCA
Os testes unitários devem cobrir todas as linhas de código incluídas na classe 
AddPrimaryContact , resultando em 100% de cobertura de código
Antes de verificar este desafio, execute sua classe de teste pelo menos uma vez usando
o recurso Executar tudo do console do desenvolvedor


*/


public class AddPrimaryContact implements Queueable {
    private Contact contacts;
    private String state;

    // Construtor que aceita um sObject Contact e uma abreviação de estado
    public AddPrimaryContact(Contact cts, String uf) {
        this.contacts = cts;
        this.state = uf;
    }

    // Método execute que insere o contato em contas com o estado especificado
    public void execute(QueueableContext context) {
        List<Account> acc = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        
        // Lista para armazenar contatos a serem inseridos
        List<Contact> contact = new List<Contact>();

        // Clonar o contato e associar a cada conta
        for (Account account : acc) {
          Contact clone = contacts.clone(false,true,false,false);
          clone.AccountId = account.Id;
          contact.add(clone);  
          
        }
        // Inserir os contatos
        if (!contact.isEmpty()) {
            insert contact;
            
        }
    }
}