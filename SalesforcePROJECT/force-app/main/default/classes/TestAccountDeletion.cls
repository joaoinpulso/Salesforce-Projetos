@isTest
private class TestAccountDeletion {
  @isTest
  static void TestDeleteAccountWithOneOpportunity() {
    //Teste a configuração dos dados
    // Crie uma conta com uma oportunidade chamando um método utilitário
    Account[] accts = TestDataFactory.createAccountsWithOpps(1,1);
    //Executa o teste
    Test.startTest();
      Database.DeleteResult result = Database.delete(accts[0], false);
    Test.stopTest();
    // Verifique se a exclusão deveria ter sido interrompida pelo gatilho,
    // então verifique se retornamos um erro.
    System.assert(!result.isSuccess());
    System.assert(result.getErrors().size() > 0);
    System.assertEquals('Cannot delete account with related opportunities.',
      result.getErrors()[0].getMessage());
  }
  @isTest
  static void TestDeleteAccountWithNoOpportunities() {
    //Teste a configuração dos dados
    // Crie uma conta sem oportunidades chamando um método utilitário
    Account[] accts = TestDataFactory.createAccountsWithOpps(1,0);
    //Executa o teste
    Test.startTest();
      Database.DeleteResult result = Database.delete(accts[0], false);
    Test.stopTest();
    //Verifica se a exclusão foi bem-sucedida
    System.assert(result.isSuccess());
  }
  @isTest
  static void TestDeleteBulkAccountsWithOneOpportunity() {
    
    //Teste a configuração dos dados
    // Cria contas com uma oportunidade cada, chamando um método utilitário
    Account[] accts = TestDataFactory.createAccountsWithOpps(200,1);
    // Executa o teste
    Test.startTest();
      Database.DeleteResult[] results = Database.delete(accts, false);
    Test.stopTest();
    //Verifica cada registro.
    // Neste caso a exclusão deveria ter sido interrompida pelo trigger,
    // então verifique se retornamos um erro.
    for(Database.DeleteResult dr : results) {
      System.assert(!dr.isSuccess());
      System.assert(dr.getErrors().size() > 0);
      System.assertEquals('Cannot delete account with related opportunities.',
        dr.getErrors()[0].getMessage());
    }
  }
  @isTest
  static void TestDeleteBulkAccountsWithNoOpportunities() {
    //Teste a configuração dos dados
    // Cria contas sem oportunidades chamando um método utilitário
    Account[] accts = TestDataFactory.createAccountsWithOpps(200,0);
    // Executa o teste
    Test.startTest();
      Database.DeleteResult[] results = Database.delete(accts, false);
    Test.stopTest();
    // Para cada registro, verifique se a exclusão foi bem-sucedida
    for(Database.DeleteResult dr : results) {
      System.assert(dr.isSuccess());
    }
  }
}



/*
private class TestAccountDeletion {
  @isTest
  static void TestDeleteAccountWithOneOpportunity() {
    // Test data setup
    // Create an account with an opportunity, and then try to delete it
    Account acct = new Account(Name='Test Account');
    insert acct;
    Opportunity opp = new Opportunity(
      Name=acct.Name + ' Opportunity',
      StageName='Prospecting',
      CloseDate=System.today().addMonths(1),
      AccountId=acct.Id);
    insert opp;
    // Perform test
    Test.startTest();
      Database.DeleteResult result = Database.delete(acct, false);
    Test.stopTest();
    // Verify
    // In this case the deletion should have been stopped by the trigger,
    // so verify that we got back an error.
    System.assert(!result.isSuccess());
    System.assert(result.getErrors().size() > 0);
    System.assertEquals('Cannot delete account with related opportunities.',
      result.getErrors()[0].getMessage());
  }
} */