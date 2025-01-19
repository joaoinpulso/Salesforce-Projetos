/*

Crie uma classe Apex que chame um endpoint REST e escreva uma classe de teste.
Crie uma classe Apex que chame um endpoint REST para retornar o nome de um animal, escreva testes unitários que alcancem 100% de cobertura de código para a classe usando uma resposta simulada e execute seus testes Apex.

Pré-trabalho : certifique-se de que os Remote Sites da primeira unidade estejam configurados.
Crie uma classe Apex:
Nome:AnimalLocator
Nome do método:getAnimalNameById
O método deve aceitar um Inteiro e retornar uma String.
O método deve chamar https://th-apex-http-callout.herokuapp.com/animals/<id>, substituindo <id> pelo ID passado para o método 
O método retorna o valor da propriedade name (ou seja, o nome do animal)
Crie uma classe de teste:
Nome:AnimalLocatorTest
A classe de teste usa uma classe simulada chamada AnimalLocatorMockpara simular a resposta de chamada
Criar testes unitários:
Os testes unitários devem cobrir todas as linhas de código incluídas na classe AnimalLocator , resultando em 100% de cobertura de código
Execute sua classe de teste pelo menos uma vez (por meio de Executar todos os testes no Console do desenvolvedor) antes de tentar verificar este desafio


*/

public class AnimalLocator{
    public static String getAnimalNameById(Integer id){
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
            req.setMethod('GET');
            Map<String, Object> animal= new Map<String, Object>();
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                animal = (Map<String, Object>) results.get('animal');
            }
            return (String)animal.get('name');
        }
}