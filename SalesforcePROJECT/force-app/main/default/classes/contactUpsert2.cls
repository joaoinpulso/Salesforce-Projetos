public with sharing class contactUpsert2 {
    public static void contactUpsert2() {
                // Verifica se já existem registros com o mesmo FirstName e LastName
                List<Contact> verificaContato = [SELECT Id, FirstName, LastName 
                FROM Contact 
                WHERE (FirstName = 'Josh' AND LastName = 'Kaplan') 
                OR (FirstName = 'Kathy' AND LastName = 'Brown')];
               
                // Mapeia os contatos existentes pelo nome completo para facilitar a verificação
                Map<String, Contact> contactMap = new Map<String, Contact>();
                for (Contact c : verificaContato) {
                    String fullName = c.FirstName + ' ' + c.LastName;
                    contactMap.put(fullName, c);
                }

                // Cria ou atualiza os contatos
                Contact josh = new Contact(FirstName='Josh', LastName='Kaplan', Department='Finance');
                Contact kathy = new Contact(FirstName='Kathy', LastName='Brown', Department='Technology');

                // Verifica se 'Josh Kaplan' já existe no sistema
                if (contactMap.containsKey('Josh Kaplan')) {
                    // Atualiza o registro existente de Josh
                    josh.Id = contactMap.get('Josh Kaplan').Id;
                    josh.Description = 'O registro de Josh foi atualizado pela operação upsert';
                }

                // Verifica se 'Kathy Brown' já existe no sistema
                if (contactMap.containsKey('Kathy Brown')) {
                    // Atualiza o registro existente de Kathy
                    kathy.Id = contactMap.get('Kathy Brown').Id;
                }

                // Lista para armazenar os novos contatos para upsert
                List<Contact> contacts = new List<Contact> {josh, kathy};

                // Chama upsert para inserir ou atualizar
                upsert contacts;

    }
}