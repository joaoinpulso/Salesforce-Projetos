@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement the respond method
    public HTTPResponse respond(HTTPRequest req) {
        // Create a new HTTPResponse
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status": "success"}');  // Simule o JSON retornado pela chamada
        res.setStatusCode(200);
        return res;
    }
}