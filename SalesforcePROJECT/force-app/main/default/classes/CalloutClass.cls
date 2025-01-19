public class CalloutClass {
    @future(callout=true)
    public static void makeCallout() {
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL.
        String endpoint = 'http://yourHost/yourService';
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        HttpResponse response = new HTTP().send(request);
    }
}
/*Para fazer um callout a partir de um acionador, chame um método de classe que execute de forma 
assíncrona. Esse método recebe o nome de método futuro e é
 anotado com @future(callout=true). Esta classe de exemplo contém o método futuro que faz o callout.
*/