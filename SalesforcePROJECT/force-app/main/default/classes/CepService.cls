public class CepService {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getCepData(String cep) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://viacep.com.br/ws/' + cep + '/json/');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            if (responseBody.containsKey('erro')) {
                throw new CalloutException('CEP inválido ou não encontrado.');
            }
            return responseBody;
        } else {
            throw new CalloutException('Erro ao consultar o CEP: ' + response.getStatus());
        }
    }
}