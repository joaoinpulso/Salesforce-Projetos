public class StringListTest {

    /*
A classe Apex deve ser chamada StringListTeste estar no escopo público
A classe Apex deve ter um método estático público chamadogenerateStringList
O método generateStringList deve retornar uma lista de strings
O método deve aceitar uma entrada Integercomo parâmetro, que será usado para determinar o número de strings retornadas
O método deve retornar uma lista de strings. Cada elemento na lista deve ter o formato Test n , onde né o índice da string 
atual na lista. Por exemplo, se a entrada for 3 , a saída deve ser ['Test 0', 'Test 1', 'Test 2'] . Lembre-se de que no Apex, 
a posição do índice do primeiro elemento em uma lista é sempre 0.
    */ 
    
    // Método estático público que gera uma lista de strings
    public static List<String> generateStringList(Integer n) {
        List<String> stringList = new List<String>();
        
        // Adiciona strings ao formato "Test n" onde n é o índice
        for (Integer i = 0; i < n; i++) {
            stringList.add('Test ' + i);
            System.debug(stringList);
        }
        
        return stringList;
    }
}