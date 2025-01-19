/*

Crie uma classe Apex que use a anotação @future para atualizar registros de conta.
Crie uma classe Apex com um método future que aceite uma Lista de IDs de Conta e atualize 
um campo personalizado no objeto Conta com o número de contatos associados à Conta. 
Escreva testes de unidade que alcancem 100% de cobertura de código para a classe. 
Cada desafio prático neste módulo pede que você crie uma classe de teste.

Crie um campo no objeto Conta:
Rótulo:Number Of Contacts
Nome:Number_Of_Contacts
Tipo: Número
Este campo conterá o número total de contatos da conta
Crie uma classe Apex:
Nome:AccountProcessor
Nome do método:countContacts
O método deve aceitar uma lista de IDs de conta
O método deve usar a anotação @future
O método conta o número de registros de contato associados a cada ID de conta passada ao método e atualiza o campo 'Number_Of_Contacts__c' com este valor
Crie uma classe de teste Apex:
Nome:AccountProcessorTest
Os testes unitários devem cobrir todas as linhas de código incluídas na classe AccountProcessor , resultando em 100% de cobertura de código.
Antes de verificar este desafio, execute sua classe de teste pelo menos uma vez usando o recurso Executar tudo do console do desenvolvedor

*/

public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
      
        // Mapeia os IDs de conta para o número de contatos associados
        Map<Id, Integer> accountContactCount = new Map<Id, Integer>();
        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) totalContacts
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accountContactCount.put((Id)ar.get('AccountId'), (Integer)ar.get('totalContacts'));
        }

        // Atualiza o campo Number_Of_Contacts__c nas contas
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            Account acc = new Account(Id = accountId);
            acc.Number_Of_Contacts__c = accountContactCount.get(accountId) != null ? accountContactCount.get(accountId) : 0;
            accountsToUpdate.add(acc);
        }

        // Realiza a atualização das contas
        update accountsToUpdate;
    }

    /* 

    O uso de AggregateResult é necessário quando você deseja realizar consultas que envolvem funções de agregação, como COUNT, SUM, AVG, etc., em SOQL (Salesforce Object Query Language). No caso da classe AccountProcessor, estamos contando o número de contatos associados a cada conta.
    Aqui está uma explicação mais detalhada sobre o porquê de usar AggregateResult:
    1. Contagem de Registros: Quando você precisa contar quantos registros (neste caso, contatos) estão associados a um grupo de registros (contas), você usa uma consulta agregada. A consulta SELECT AccountId, COUNT(Id) totalContacts retorna um conjunto de resultados onde cada linha representa uma conta e o número total de contatos associados a essa conta.
    2. Estrutura de Dados: AggregateResult é a estrutura de dados que o Salesforce retorna para consultas que utilizam funções de agregação. Ele permite acessar os resultados agregados através de métodos como get(), onde você pode especificar o nome do campo agregado (neste caso, totalContacts).
    Eficiência: Usar uma consulta agregada é mais eficiente do que buscar todos os contatos individualmente e depois contá-los em Apex. Isso reduz o número de chamadas de banco de dados e melhora o desempenho.
    Se você preferir uma abordagem sem AggregateResult, você teria que buscar todos os contatos associados a cada conta e contá-los manualmente, o que não é tão eficiente. No entanto, se você quiser uma versão sem AggregateResult, aqui está um exemplo:
    Classe Apex sem AggregateResult
    Ask
    Copy
    Apply


    public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) return;

        // Busca todos os contatos associados às contas
        List<Contact> contacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accountIds];
        
        // Mapeia o número de contatos por conta
        Map<Id, Integer> accountContactCount = new Map<Id, Integer>();
        for (Contact c : contacts) {
            if (accountContactCount.containsKey(c.AccountId)) {
                accountContactCount.put(c.AccountId, accountContactCount.get(c.AccountId) + 1);
            } else {
                accountContactCount.put(c.AccountId, 1);
            }
        }

        // Atualiza contas com o número de contatos
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            accountsToUpdate.add(new Account(Id = accountId, Number_Of_Contacts__c = accountContactCount.get(accountId) != null ? accountContactCount.get(accountId) : 0));
        }

        update accountsToUpdate;
    }
}

Explicação da Nova Abordagem
Busca de Contatos: A consulta busca todos os contatos associados às contas.
Contagem Manual: A contagem é feita manualmente em um loop, onde incrementamos o contador para cada contato encontrado.
Essa abordagem é mais simples, mas pode ser menos eficiente em termos de desempenho, especialmente se houver muitos contatos associados a várias contas.


    */
}