public with sharing class CepAbertoService {
    private static final String BASE_URL = 'https://www.cepaberto.com/api/v3/cep';

    /**
     * Consulta a API do CEP Aberto com um CEP parcial ou completo.
     * @param query String - Parte do CEP ou CEP completo.
     * @return List<String> - Lista de sugestões de endereços.
     */
    @AuraEnabled(cacheable=true)
    public static List<String> searchCep(String query) {
        List<String> suggestions = new List<String>();

        try {
            // Configurar a chamada HTTP
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(BASE_URL + '?cep=' + EncodingUtil.urlEncode(query, 'UTF-8'));
            request.setMethod('GET');
            request.setHeader('Authorization', 'Token token=0fc89dcf53c9b8f8a91be2f75f1673e5');

            // Executar a chamada
            HttpResponse response = http.send(request);

            // Verificar resposta
            if (response.getStatusCode() == 200) {
                // Processar resposta JSON
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

                if (result != null) {
                    // Adicionar sugestões
                    String cep = (String) result.get('cep');
                    String logradouro = (String) result.get('logradouro');
                    String bairro = (String) result.get('bairro');
                    String cidade = (String) ((Map<String, Object>) result.get('cidade')).get('nome');
                    String estado = (String) ((Map<String, Object>) result.get('estado')).get('sigla');

                    suggestions.add(cep + ' - ' + logradouro + ', ' + bairro + ', ' + cidade + ', ' + estado);
                }
            }
        } catch (Exception ex) {
            // Log erro (pode personalizar)
            System.debug('Erro ao buscar CEP: ' + ex.getMessage());
        }

        return suggestions;
    }
}