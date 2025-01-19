public with sharing class contactUpsert {
    public static void contactUpsert() {
        //Insira o contato do Josh
        Contact josh = new Contact (FirstName='Josh',LastName='Kaplan',Department='Finance');       
        insert josh;

        // O registro de Josh foi inserido
        // então a variável josh agora tem um ID
        // que será usado para corresponder os registros por upsert
        josh.Description = 'O registro de Josh foi atualizado pela operação upsert';
        
        // Cria o contato Kathy, mas não o persiste no banco de dados
        Contact kathy = new Contact (FirstName='Kathy',LastName='Brown',Department='Technology');
        
        // Lista para armazenar os novos contatos para upsert    
        List<Contact> contacts = new List<Contact> {josh, kathy};
        
        //Chama upsert
        upsert contacts;
        // Resultado: Josh é atualizado e Kathy é criada.
    }
}