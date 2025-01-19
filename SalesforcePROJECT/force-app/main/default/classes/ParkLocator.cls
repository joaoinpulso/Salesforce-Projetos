public class ParkLocator {
    public static String[] country(String countryName) {
        // Instancia o serviço SOAP gerado pelo wsdl2apex
        ParkService.ParksImplPort service = new ParkService.ParksImplPort();
        
        try {
            // Chama o método byCountry para buscar os parques
            return service.byCountry(countryName);
        } catch (Exception e) {
            // Loga o erro e retorna uma matriz vazia em caso de falha
            System.debug('Erro ao chamar o serviço SOAP: ' + e.getMessage());
            return new String[0];
        }
    }
}