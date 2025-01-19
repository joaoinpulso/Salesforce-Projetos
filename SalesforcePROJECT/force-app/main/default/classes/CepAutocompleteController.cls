public with sharing class CepAutocompleteController {
    @AuraEnabled(cacheable=true)
    public static List<String> getSuggestions(String query) {
        String baseUrl = 'https://www.cepaberto.com/api/v3/cep';
        String url = baseUrl + '?cep=' + EncodingUtil.urlEncode(query, 'UTF-8');
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Token token=0fc89dcf53c9b8f8a91be2f75f1673e5');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        System.debug('Response Status: ' + res.getStatusCode());
        System.debug('Response Body: ' + res.getBody());
        
        List<String> suggestions = new List<String>();
        
        if (res.getStatusCode() == 200) {
            String jsonResponse = res.getBody();
            Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
            
            if (resultMap.containsKey('logradouro') && resultMap.containsKey('bairro') && resultMap.containsKey('cidade') && resultMap.containsKey('estado')) {
                String cidade = (String)((Map<String, Object>)resultMap.get('cidade')).get('nome');
                String estado = (String)((Map<String, Object>)resultMap.get('estado')).get('sigla');
                String suggestion = resultMap.get('logradouro') + ' - ' + resultMap.get('bairro') + ', ' + cidade + ' - ' + estado;
                suggestions.add(suggestion);
            }
        } else {
            throw new CalloutException('Erro no status da integração' + res.getStatus());
        }
        
        return suggestions;
    }
}