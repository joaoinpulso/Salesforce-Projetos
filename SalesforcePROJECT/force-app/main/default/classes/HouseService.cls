/*Code Highlights (Destaques do código) Nesse código, você cria uma classe HouseService que tem um método chamado getRecords. O método retorna a lista de registros de casas (como uma coleção ordenada) consultando o objeto House__c.
Observe que, na classe do Apex HouseService, você exibe automaticamente o objeto (House__c) criado anteriormente (na Etapa 2) como uma classe sem gravar um arquivo de classe. Além disso, você pode fazer referência aos campos no objeto House__c como propriedades sem precisar declará-los.
Usamos SOQL para escrever nossas consultas fazendo referência ao objeto e aos campos no objeto. A consulta é compilada e, portanto, é verificada quanto a tipificação em tempo de compilação.
Você estabeleceu uma forte ligação entre o modelo de dados e a classe do Apex. Agora você não poderá quebrar o código porque ele não será compilado se você fizer uma alteração de código inconsistente com o modelo de dados.*/
public with sharing class HouseService {
    @AuraEnabled(cacheable=true)
    public static List<House__c> getRecords() {
        try {
            // Create a list of House records from a SOQL query
            List<House__c> lstHouses = [
                SELECT
                   Id,
                   Name,
                   Address__c,
                   State__c,
                   City__c,
                   Zip__c
                   FROM House__c
                   WITH USER_MODE
                   ORDER BY CreatedDate
                   LIMIT 10
                ];
                  return lstHouses;
        }
        // Code to handle exception
        catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
        }
    }
}