/*  
Tornar sua classe Apex disponível como um serviço web SOAP é tão fácil quanto com REST. 
Defina sua classe como global. 
Adicione a webservicepalavra-chave e o staticmodificador de definição a cada método que você deseja expor. 
A webservicepalavra-chave fornece acesso global ao método ao qual é adicionada.

Por exemplo, aqui está uma classe de amostra com um método. 
O getRecordmétodo é uma chamada de API SOAP personalizada que retorna um registro Account.
*/
        global with sharing class MySOAPWebService {
            webservice static Account getRecord(String id) {
                Account account = new Account();
                return account;
                // Add your code
            }
        }