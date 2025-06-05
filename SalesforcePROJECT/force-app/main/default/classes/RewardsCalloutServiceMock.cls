@isTest
global class RewardsCalloutServiceMock implements HttpCalloutMock {

    protected Integer statusCode;
    // Variável estática para rastrear o corpo da requisição, se necessário para asserções
    public static String lastRequestBody; 
    public static Boolean wasCalled = false;


    global RewardsCalloutServiceMock(Integer statusCode) {
        this.statusCode = statusCode;
    }

    global HTTPResponse respond(HTTPRequest req) {
        lastRequestBody = req.getBody(); // Captura o corpo da requisição
        wasCalled = true;

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        if (this.statusCode == 201) {
            res.setBody('{"message": "Success"}'); // Exemplo de corpo de sucesso
        } else {
            res.setBody('{"error": "Simulated error"}'); // Exemplo de corpo de erro
        }
        res.setStatusCode(this.statusCode);
        res.setStatus((this.statusCode == 201 ? 'Created' : 'Error'));
        return res;
    }
}