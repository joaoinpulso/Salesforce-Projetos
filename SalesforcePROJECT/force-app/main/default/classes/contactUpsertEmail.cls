public with sharing class contactUpsertEmail {
    public static void contactUpsertEmail() {

        Contact jane = new Contact (FirstName='Jane',
                                    LastName='Smith',
                                    Email='jane.smith@example.com',
                                    Description='Contact of the day');

                                    insert jane;
           
             // 1. Upsert usando um campo idLookup
            // Cria uma segunda variável sObject.
            // Esta variável não possui nenhum ID definido.

        Contact jane2 = new Contact (FirstName='Jane',
                                    LastName='Smith',
                                    Email='jane.smith@example.com',
                                    Description='Prefere ser contatado por e-mail.');

                                    insert jane2;

                        // Atualize o contato usando o campo idLookup para correspondência.
                        upsert jane2 Contact.fields.Email;

                        //Verifica se o contato foi atualizado
                        System.assertEquals('Prefere ser contatado por e-mail.',
                            [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);

                   try {

                    //Isso causa uma exceção porque 
                    // o campo Nome obrigatório não é fornecido.
                    Account acc = new Account ();

                    //insere conta
                    insert acc;
                    
                   } catch (DmlException e ) {

                    System.debug('Ocorreu uma exceção DML: ' + e.getMessage());

                    
                   }


    }
}