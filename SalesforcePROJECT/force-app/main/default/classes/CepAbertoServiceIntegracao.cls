public with sharing class CepAbertoServiceIntegracao {
        private static final String BASE_URL_CEP = 'https://www.cepaberto.com/api/v3/cep';
        private static final String BASE_URL_ADDRESS = 'https://www.cepaberto.com/api/v3/address';
        private static final String AUTH_TOKEN = 'Token token=0fc89dcf53c9b8f8a91be2f75f1673e5';
    
        @AuraEnabled(cacheable=true)
        public static Map<String, Object> searchByCep(String cep) {
            String url = BASE_URL_CEP + '?cep=' + EncodingUtil.urlEncode(cep, 'UTF-8');
            return makeRequest(url);
        }
    
        @AuraEnabled(cacheable=true)
        public static Map<String, Object> searchByAddress(String estado, String cidade, String logradouro) {
            String url = BASE_URL_ADDRESS + '?estado=' + EncodingUtil.urlEncode(estado, 'UTF-8') +
                         '&cidade=' + EncodingUtil.urlEncode(cidade, 'UTF-8') +
                         '&logradouro=' + EncodingUtil.urlEncode(logradouro, 'UTF-8');
            return makeRequest(url);
        }
    
        private static Map<String, Object> makeRequest(String url) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            req.setHeader('Authorization', AUTH_TOKEN);
    
            Http http = new Http();
            HttpResponse res = http.send(req);
    
            if (res.getStatusCode() == 200) {
                return (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            } else {
                System.debug('Error fetching data from API: ' + res.getStatusCode());
                return new Map<String, Object>();
            }
        }
    }