public class ContactSearch {
    // Método estático público que aceita dois parâmetros de string
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        // Verifica se os parâmetros de entrada não são nulos ou vazios
        if (String.isEmpty(lastName) || String.isEmpty(postalCode)) {
            return new List<Contact>(); // Retorna uma lista vazia se os parâmetros não são válidos
        }

        // Consulta SOQL para encontrar contatos com base nos parâmetros fornecidos
        List<Contact> contacts = [SELECT Id, Name 
                                   FROM Contact 
                                   WHERE LastName = :lastName 
                                   AND MailingPostalCode = :postalCode];

        return contacts; // Retorna a lista de contatos encontrados
    }
}