// public class RewardsCalloutService {
//     public static HttpResponse submitUsersForRewardCallout(String jsonBody) {
//         HttpRequest request = new HttpRequest();
//         request.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards');
//         request.setMethod('POST');
//         request.setHeader('Content-Type', 'application/json;charset=UTF--8');
//         request.setBody(jsonBody);

//         Http http = new Http();
//         HttpResponse response = null;

//         try {
//             response = http.send(request);
//         } catch (System.CalloutException e) {
//             System.debug('RewardsCalloutService: Callout error: ' + e.getMessage());
//             response = new HttpResponse();
//             response.setStatusCode(500);
//             response.setStatus('Error');
//             response.setBody('Callout failed: ' + e.getMessage());
//         }
//         return response;
//     }
// }
public class RewardsCalloutService {
    public static Integer submitUsersForRewardCallout(String jsonBody) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:BalancedLiving/rewards');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);

        Http http = new Http();
        HttpResponse res;
        Integer statusCode;
        try {
            res = http.send(req);
            statusCode = res.getStatusCode();
            System.debug('Response Status: ' + statusCode);
            System.debug('Response Body: ' + res.getBody());
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            statusCode = 500; // Internal Server Error
        }
        return statusCode;
    }
}