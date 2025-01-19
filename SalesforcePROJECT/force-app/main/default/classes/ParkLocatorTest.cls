@IsTest
public class ParkLocatorTest {
    @IsTest
    static void testCountryWithValidResponse() {
        // Define o mock para o serviço SOAP
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Testa para Alemanha
        String[] germanyParks = ParkLocator.country('Germany');
        System.assertEquals(2, germanyParks.size());
        System.assertEquals('Black Forest', germanyParks[0]);
        System.assertEquals('Saxon Switzerland', germanyParks[1]);

        // Testa para Índia
        String[] indiaParks = ParkLocator.country('India');
        System.assertEquals(2, indiaParks.size());
        System.assertEquals('Jim Corbett', indiaParks[0]);
        System.assertEquals('Kaziranga National Park', indiaParks[1]);

        // Testa para Japão
        String[] japanParks = ParkLocator.country('Japan');
        System.assertEquals(2, japanParks.size());
        System.assertEquals('Fuji Hakone Izu', japanParks[0]);
        System.assertEquals('Shiretoko National Park', japanParks[1]);

        // Testa para Estados Unidos
        String[] usParks = ParkLocator.country('United States');
        System.assertEquals(2, usParks.size());
        System.assertEquals('Yellowstone', usParks[0]);
        System.assertEquals('Grand Canyon', usParks[1]);
    }

    @IsTest
    static void testCountryWithNoResponse() {
        // Define o mock para o serviço SOAP
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Testa para um país inválido
        String[] unknownParks = ParkLocator.country('UnknownCountry');
        System.assertEquals(0, unknownParks.size());
    }

    @IsTest
    static void testCountryWithError() {
        // Define o mock para o serviço SOAP que lança exceção
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Força o serviço a gerar uma exceção
        Test.startTest();
        String[] emptyResponse = ParkLocator.country(null);
        Test.stopTest();
        
        System.assertEquals(0, emptyResponse.size());
    }

    @IsTest
    static void testeCatch() {
        // Define o mock para o serviço SOAP
        try {
            Test.startTest();
            String[] emptyResponse = ParkLocator.country('Brasileiiro');
            Test.stopTest();
        
        } catch (Exception e) {
            
        }
        
    }
}