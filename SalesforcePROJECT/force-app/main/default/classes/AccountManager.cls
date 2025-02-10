/* 
Crie um serviço Apex REST que retorne uma conta e seus contatos.
Crie uma classe REST Apex que seja acessível em /Accounts/<Account_ID>/contacts. 
O serviço retornará o ID e o nome da conta, além do ID e do nome de todos os contatos associados à conta. 
Escreva testes de unidade que alcancem 100% de cobertura de código para a classe e execute seus testes Apex.

Pré-trabalho : certifique-se de que os sites remotos da primeira unidade estejam configurados.
Crie uma classe Apex
Nome:AccountManager
A classe deve ter um método chamadogetAccount
O método deve ser anotado com @HttpGet e retornar um objeto Account
O método deve retornar o ID e o nome do registro solicitado e todos os contatos associados com seu ID e nome
Criar testes unitários
Os testes de unidade devem estar em uma classe Apex separada chamadaAccountManagerTest
Os testes unitários devem cobrir todas as linhas de código incluídas na classe AccountManager , resultando em 100% de cobertura de código
Execute sua classe de teste pelo menos uma vez (por meio de Executar todos os testes no Console do desenvolvedor) antes de tentar verificar este desafio
*/
@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substringBetween('Accounts/', '/contacts');
        Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) 
                       FROM Account WHERE Id = :accId];
        return acc;
    }
}