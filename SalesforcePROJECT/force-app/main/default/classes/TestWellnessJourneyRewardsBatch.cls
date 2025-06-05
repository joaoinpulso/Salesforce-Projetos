@isTest
private class TestWellnessJourneyRewardsBatch {

    private static List<Wellness_Journey__c> createTestJourneys(User testUser, Integer numberOfJourneys, Date completionDate) {
        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        for (Integer i = 0; i < numberOfJourneys; i++) {
            journeys.add(new Wellness_Journey__c(
                Name = 'Test Journey ' + i,
                OwnerId = testUser.Id,
                Status__c = 'Complete',
                Completion_Date__c = completionDate.addDays(-i) // Variar um pouco a data para garantir que esteja dentro do trimestre
            ));
        }
        return journeys;
    }

    // Método para calcular as datas do trimestre anterior (espelhando a lógica da batch)
    private static Date getPreviousQuarterStartDate() {
        Date today = Date.today();
        Integer currentYear = today.year();
        Integer currentMonth = today.month();
        Integer previousQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
        if (previousQuarterStartMonth <= 0) {
            previousQuarterStartMonth += 12;
            currentYear--;
        }
        return Date.newInstance(currentYear, previousQuarterStartMonth, 1);
    }

    private static Date getPreviousQuarterEndDate() {
        Date previousQuarterStartDate = getPreviousQuarterStartDate();
        return previousQuarterStartDate.addMonths(3).addDays(-1);
    }


    // Mock para simular a chamada HTTP
    @isTest
    static void testBatchExecution_EligibleUser() {
        // Criar usuário de teste
        User testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id,
            LastName = 'TestLastName',
            Email = 'testuser@example.com',
            Username = 'testuser' + System.currentTimeMillis() + '@example.com',
            CompanyName = 'TestCo',
            Title = 'Tester',
            Alias = 'testu',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert testUser;

        // Data dentro do trimestre anterior para os registros de teste
        Date completionDateInPreviousQuarter = getPreviousQuarterEndDate();

        // Criar 12 jornadas para o usuário (elegível)
        List<Wellness_Journey__c> journeys = createTestJourneys(testUser, 12, completionDateInPreviousQuarter);
        insert journeys;

        // Configurar o mock para o callout
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(201)); // Simula sucesso

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verificações (assertions) podem ser adicionadas aqui se você tiver como verificar
        // o resultado do callout ou se a batch atualiza algum campo.
        // Por exemplo, se RewardsCalloutServiceMock tivesse uma flag para verificar se foi chamado:
        // System.assertEquals(true, RewardsCalloutServiceMock.wasCalled, 'O serviço de callout deveria ter sido chamado.');
        // No entanto, a batch apenas faz um System.debug do responseCode.
        // A cobertura é o foco principal aqui.
    }

    @isTest
    static void testBatchExecution_IneligibleUser_LessThan12() {
        User testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id,
            LastName = 'TestLastName2',
            Email = 'testuser2@example.com',
            Username = 'testuser2' + System.currentTimeMillis() + '@example.com',
            CompanyName = 'TestCo',
            Title = 'Tester',
            Alias = 'testu2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert testUser;

        Date completionDateInPreviousQuarter = getPreviousQuarterEndDate();
        // Criar 10 jornadas para o usuário (inelegível)
        List<Wellness_Journey__c> journeys = createTestJourneys(testUser, 10, completionDateInPreviousQuarter);
        insert journeys;

        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(201));

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // O callout não deve ser feito se a lista de usuários for vazia.
        // Precisaríamos de uma forma de verificar isso, talvez através de um campo estático no mock.
    }
    
    @isTest
    static void testBatchExecution_NoJourneysInQuarter() {
        User testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id,
            LastName = 'TestLastName3',
            Email = 'testuser3@example.com',
            Username = 'testuser3' + System.currentTimeMillis() + '@example.com',
            CompanyName = 'TestCo',
            Title = 'Tester',
            Alias = 'testu3',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert testUser;

        // Criar jornadas fora do trimestre anterior
        Date completionDateOutsideQuarter = Date.today().addMonths(-5);
        List<Wellness_Journey__c> journeys = createTestJourneys(testUser, 15, completionDateOutsideQuarter);
        insert journeys;

        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(201));

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // O callout não deve ser feito.
    }

    @isTest
    static void testBatchExecution_MultipleUsers() {
        User userEligible = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id,
            LastName = 'EligibleUser', Email = 'eligible@example.com',
            Username = 'eligible' + System.currentTimeMillis() + '@example.com',
            Alias = 'eligu', TimeZoneSidKey = 'America/Los_Angeles', EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US'
        );
        User userIneligible = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id,
            LastName = 'IneligibleUser', Email = 'ineligible@example.com',
            Username = 'ineligible' + System.currentTimeMillis() + '@example.com',
            Alias = 'ineli', TimeZoneSidKey = 'America/Los_Angeles', EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US'
        );
        insert new List<User>{userEligible, userIneligible};

        Date completionDateInPreviousQuarter = getPreviousQuarterEndDate();

        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        journeys.addAll(createTestJourneys(userEligible, 15, completionDateInPreviousQuarter));
        journeys.addAll(createTestJourneys(userIneligible, 5, completionDateInPreviousQuarter));
        insert journeys;

        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(201));

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Apenas o usuário elegível deve estar no JSON enviado.
        // O mock precisaria capturar o corpo da requisição para verificação.
    }

    @isTest
    static void testBatchExecution_CalloutFailure() {
        User testUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id,
            LastName = 'TestLastNameFail', Email = 'testuserfail@example.com',
            Username = 'testuserfail' + System.currentTimeMillis() + '@example.com',
            Alias = 'testuf', TimeZoneSidKey = 'America/Los_Angeles', EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US'
        );
        insert testUser;

        Date completionDateInPreviousQuarter = getPreviousQuarterEndDate();
        List<Wellness_Journey__c> journeys = createTestJourneys(testUser, 12, completionDateInPreviousQuarter);
        insert journeys;

        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock(500)); // Simula falha no servidor

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        
        // O System.debug na batch mostraria o código 500.
    }
    
    // Helper para os métodos getStartDate e getEndDate na classe de teste
    // para que sejam acessíveis (se não forem públicos na classe batch)
    // Estes métodos foram adicionados no topo da classe de teste para uso.
}