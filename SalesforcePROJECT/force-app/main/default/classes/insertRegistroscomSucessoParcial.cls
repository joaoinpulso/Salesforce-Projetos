public with sharing class insertRegistroscomSucessoParcial {
    public insertRegistroscomSucessoParcial() {

        //Crie lista de contatos
        List <Contact> conlist = new List<Contact> {

            new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
            new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
            new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
            new Contact()

        };

        //Inserir em massa todos os contatos com uma chamada DML
        Database.SaveResult[] ListaDATABASE = Database.insert(conList, false);

        
        // Itera através de cada resultado retornado
        for (Database.SaveResult db : ListaDATABASE) {

            if (db.isSuccess()) {
                //A operação foi bem-sucedida, então obtenha o ID do registro que foi processado
                System.debug('Contato inserido com sucesso. ID do contato: ' + db.getId());
            } 
            else {
                
                    // A operação falhou, então obtenha todos os erros

                    for (Database.Error err : db.getErrors()) {
                        System.debug ('Ocorreu o seguinte erro.');
                        System.debug (err.getStatusCode() + ':' + err.getMessage());
                        System.debug ('Campos de contato que afetaram este erro:' + err.getFields());
                        
                    }
            }

            
        }
    }
}