@isTest
private class RewardsCalloutServiceTest  {

    // Success scenario
    @isTest
    static void testSubmitUsersForRewardCallout_Success() {
        Test.setMock(HttpCalloutMock.class, new MockSuccess());

        String jsonBody = '[{"userId":"005xx0000012345", "fullName":"Test User", "email":"test@example.com", "username":"test.user"}]';

        Test.startTest();
        Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
        Test.stopTest();

        System.assertEquals(200, responseCode, 'Expected HTTP 200 response');
    }

    // Failure scenario
    @isTest
    static void testSubmitUsersForRewardCallout_Failure() {
        Test.setMock(HttpCalloutMock.class, new MockFailure());

        String jsonBody = '[{"userId":"005xx0000012345", "fullName":"Test User", "email":"test@example.com", "username":"test.user"}]';

        Test.startTest();
        Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
        Test.stopTest();

        System.assertEquals(500, responseCode, 'Expected HTTP 500 response due to simulated exception');
    }

    // Mock for success response
    private class MockSuccess implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success"}');
            res.setStatusCode(200);
            return res;
        }
    }

    // Mock for failure (throws exception)
    private class MockFailure implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            throw new CalloutException('Simulated callout error');
        }
    }
}