/*
    Tornar sua classe Apex disponível como um serviço web REST é simples.
    Defina sua classe como global e defina métodos como estáticos globais.
    Adicione anotações à classe e aos métodos.
    Por exemplo, esta classe REST Apex de exemplo usa um método.
    O getRecordmétodo é uma chamada REST API personalizada.
    Ele é anotado com @HttpGete é invocado para uma solicitação GET.*/

        @RestResource(urlMapping='/Account/*')
        global with sharing class MyRestResource {
            @HttpGet
            global static Account getRecord() {
                Account account = new Account();
                return account;// Add your code
            }
    /*
    Como você pode ver, a classe é anotada com @RestResource(urlMapping='/Account/*'). 
    O ponto de extremidade base para Apex REST é https://yourInstance.my.salesforce.com/services/apexrest/. 
    O mapeamento de URL é anexado ao ponto de extremidade base para formar o ponto de extremidade para seu serviço REST. 
    No exemplo de classe, o ponto de extremidade REST é https://yourInstance.my.salesforce.com/services/apexrest/. 
    Para sua organização, poderia ser algo como https://yourInstance.my.salesforce.com/services/apexrest/Account/*.
    */
}