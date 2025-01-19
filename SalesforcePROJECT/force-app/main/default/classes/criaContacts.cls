public with sharing class criaContacts {
    public static void criaContacts() {
        //criar lista de contatos para serem inseridos ou atualizados

        List<Contact> listcontact = new List<Contact>{

            new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
            new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
            new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
            new Contact(FirstName='Kim',LastName='Shain',Department='Education')
        };

        //inserir lista de contatos
        insert listcontact;

        //lista de contatos para serem atualizados
        List<Contact> listToUpdate = new List<Contact>();
        //itera na lista e add o title only

        for (Contact con : listcontact) {
            if (con.Department == 'Finance') {
                con.Title = 'Financial analyst';

                //adicionar o contato atualizado na lista
                listToUpdate.add(con);
                
            }
            
        }
        // atualizar lista de contatos
        update listToUpdate;
    }
        
    

}