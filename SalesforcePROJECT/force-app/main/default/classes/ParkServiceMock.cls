@IsTest
global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseName,
        String responseNamespace,
        String responseType
    ) {
        // Verifica o argumento de entrada (país)
        ParkService.byCountry requestObj = (ParkService.byCountry) request;
        String countryName = requestObj.arg0;
        
        // Configura a resposta simulada
        ParkService.byCountryResponse responseObj = new ParkService.byCountryResponse();
        
        if (countryName == 'Germany') {
            responseObj.return_x = new String[]{'Black Forest', 'Saxon Switzerland'};
        } else if (countryName == 'India') {
            responseObj.return_x = new String[]{'Jim Corbett', 'Kaziranga National Park'};
        } else if (countryName == 'Japan') {
            responseObj.return_x = new String[]{'Fuji Hakone Izu', 'Shiretoko National Park'};
        } else if (countryName == 'United States') {
            responseObj.return_x = new String[]{'Yellowstone', 'Grand Canyon'};
        } else {
            responseObj.return_x = new String[]{}; // Retorna vazio para países desconhecidos
        }
        
        // Adiciona a resposta ao mapa
        response.put('response_x', responseObj);
    }
}