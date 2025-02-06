/*
Tornar sua classe Apex disponível como um serviço web REST é simples. 
Defina sua classe como global e defina métodos como estáticos globais. 
Adicione anotações à classe e aos métodos. 
Por exemplo, esta classe REST Apex de exemplo usa um método. 
O getRecordmétodo é uma chamada REST API personalizada. 
Ele é anotado com @HttpGete é invocado para uma solicitação GET.
 */
@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {
    @HttpGet
    global static Account getRecord() {
        Account account = new Account();
        return account;// Add your code
    }
}