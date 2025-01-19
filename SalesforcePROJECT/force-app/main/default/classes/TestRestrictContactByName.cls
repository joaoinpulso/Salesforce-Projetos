@isTest
private class TestRestrictContactByName {
    @isTest
    static void TestInsertOrUpdateContact() {
        // Instanciar o contato, mas não realizar a inserção aqui
        Contact c = new Contact(LastName = 'INVALIDNAME');

        Test.startTest();
        // Tentar inserir o contato com o nome inválido
        Database.SaveResult result = Database.insert(c, false);
        
        // Tentar atualizar o mesmo contato
        Database.SaveResult result2 = Database.update(c, false);
        Test.stopTest();
          
        // Verificações para garantir que as operações falharam
        System.assert(!result.isSuccess(), 'Inserção deveria falhar');
        System.assert(!result2.isSuccess(), 'Atualização deveria falhar');
        
        // Verificar se os erros estão sendo gerados corretamente
        System.assert(result.getErrors().size() > 0, 'Erro esperado na inserção');
        System.assert(result2.getErrors().size() > 0, 'Erro esperado na atualização');
        
        // Comparar a mensagem de erro
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
            result.getErrors()[0].getMessage(), 'Mensagem de erro incorreta');

        }



        /*  ***** ALTERAÇÕES ********

            Alterações:
            Remoção do Database.SaveResult: A operação de DML está lançando uma exceção, então agora estamos utilizando try-catch E
            para capturar essa exceção e verificar a mensagem.
            Validação dentro de try-catch: Ao invés de usar SaveResult, capturamos a exceção DmlException e verificamos se a mensagem
            contém a string esperada.
            System.assert(false) no bloco try: Isso garante que o teste falhe se a inserção ou atualização não lançar uma exceção, 
            como deveria acontecer devido à validação personalizada.
                    
                            @isTest
                    private class TestRestrictContactByName {
                        @isTest
                        static void TestInsertOrUpdateContact() {
                            // Criar o contato com LastName inválido
                            Contact c = new Contact(LastName = 'INVALIDNAME');
                            
                            Test.startTest();
                            
                            // Captura de exceção ao tentar inserir
                            try {
                                insert c;
                                System.assert(false, 'A inserção deveria ter falhado devido à validação.');
                            } catch (DmlException e) {
                                // Verificar se a mensagem de erro está correta
                                System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'), 
                                    'Mensagem de erro incorreta.');
                            }
                            
                            // Tentar a atualização e capturar exceção
                            try {
                                update c;
                                System.assert(false, 'A atualização deveria ter falhado devido à validação.');
                            } catch (DmlException e) {
                                // Verificar se a mensagem de erro está correta
                                System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'), 
                                    'Mensagem de erro incorreta.');
                            }
                            
                            Test.stopTest();
                        }
                    }
        
        */
    }