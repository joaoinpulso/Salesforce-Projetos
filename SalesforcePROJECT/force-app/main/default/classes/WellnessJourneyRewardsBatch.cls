// global class WellnessJourneyRewardsBatch implements Database.Batchable<AggregateResult>, Database.AllowsCallouts, Database.Stateful {
//     public class UserRewardInfo {
//         public String userId;
//         public String fullName;
//         public String email;
//         public String username;

//         public UserRewardInfo(String userId, String fullName, String email, String username) {
//             this.userId = userId;
//             this.fullName = fullName;
//             this.email = email;
//             this.username = username;
//         }
//     }

//     private List<UserRewardInfo> eligibleUsersForReward;

//     global WellnessJourneyRewardsBatch() {
//         this.eligibleUsersForReward = new List<UserRewardInfo>();
//     }

//     global Iterable<AggregateResult> start(Database.BatchableContext bc) {
//         String queryString = 'SELECT User__r.Id userId, User__r.Name userFullName, User__r.Username userUsername, User__r.Email userEmail, COUNT(Id) completedActivities ' +
//                            'FROM Wellness_Journey__c ' +
//                            'WHERE Status__c = \'Completed\' ' + // Substitua 'Completed' pelo valor correto
//                            'GROUP BY User__r.Id, User__r.Name, User__r.Username, User__r.Email ' +
//                            'HAVING COUNT(Id) >= 12';
        
//         List<AggregateResult> aggregateResultsList = new List<AggregateResult>();
//         for(SObject sObj : Database.query(queryString)){
//             aggregateResultsList.add((AggregateResult)sObj);
//         }
//         return aggregateResultsList;
//     }

//     global void execute(Database.BatchableContext bc, List<AggregateResult> scope) {
//         System.debug('WellnessJourneyRewardsBatch.execute: Processing ' + scope.size() + ' aggregated results.');
//         for (AggregateResult ar : scope) {
//             String empId = (String)ar.get('userId');
//             String empName = (String)ar.get('userFullName'); 
//             String empUsername = (String)ar.get('userUsername');
//             String empEmail = (String)ar.get('userEmail');

//             eligibleUsersForReward.add(new UserRewardInfo(empId, empName, empEmail, empUsername));
//             System.debug('WellnessJourneyRewardsBatch.execute: Added user for reward processing: ' + empId);
//         }
//     }

//     global void finish(Database.BatchableContext bc) {
//         System.debug('WellnessJourneyRewardsBatch.finish: Batch processing finished. Total eligible users found: ' + eligibleUsersForReward.size());
//         if (!eligibleUsersForReward.isEmpty()) {
//             String jsonBody = JSON.serialize(eligibleUsersForReward);
//             System.debug('WellnessJourneyRewardsBatch.finish: Serialized JSON payload: ' + jsonBody);
//             HttpResponse response = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
//             System.debug('WellnessJourneyRewardsBatch.finish: Response Code from RewardsCalloutService: ' + response.getStatusCode());
//             System.debug('WellnessJourneyRewardsBatch.finish: Response Status from RewardsCalloutService: ' + response.getStatus());
//             System.debug('WellnessJourneyRewardsBatch.finish: Response Body from RewardsCalloutService: ' + response.getBody());

//             if (response.getStatusCode() == 201) {
//                 System.debug('WellnessJourneyRewardsBatch.finish: Users successfully submitted for rewards.');
//             } else {
//                 System.debug('WellnessJourneyRewardsBatch.finish: Failed to submit users for rewards. Status: ' + response.getStatusCode() + ' - ' + response.getBody());
//             }
//         } else {
//             System.debug('WellnessJourneyRewardsBatch.finish: No eligible users found to submit for rewards.');
//         }
//     }
// }
global class WellnessJourneyRewardsBatch implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts {

     global Database.QueryLocator start(Database.BatchableContext BC) {
    
        Date startDate = getStartDate();                
        Date endDate = getEndDate();

        String query = 'SELECT Id,Name,OwnerId, Owner.Name, Owner.Email, Owner.Username FROM Wellness_Journey__c WHERE Status__c = \'Complete\' AND Completion_Date__c >= :startDate AND Completion_Date__c <= :endDate ORDER BY OwnerId, Completion_Date__c';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Wellness_Journey__c> scope) {
        Map<Id, Integer> userGoalCountMap = new Map<Id, Integer>();
        Set<Id> uniqueUserId = new Set<Id>();
        //Array of JSON objects
        List<Map<String, Object>> usersListMap = new List<Map<String, Object>>();
               
        // Initialize the map with user IDs and set the initial count to 0
        
        for (Wellness_Journey__c journey : scope) {
            userGoalCountMap.put(journey.OwnerId, 0);        
        } 
        
        for (Wellness_Journey__c journey : scope) {
        
            // Calculate the number of journeys completed by each user
            Integer goalCount = userGoalCountMap.get(journey.OwnerId);
            goalCount++;
            userGoalCountMap.put(journey.OwnerId,goalCount);

            // Check if the user has completed atleast 12 goals in the quarter and hasn't already been added to the array
            if(userGoalCountMap.get(journey.OwnerId)>=12 && !uniqueUserId.contains(journey.OwnerId)){
            
            Map<String, Object> userObj = new Map<String, Object>();

                uniqueUserId.add(journey.OwnerId);
               
                //Build JSON object    
                
                userObj.put('userId',journey.OwnerId);
                userObj.put('fullName',journey.Owner.Name);
                userObj.put('email',journey.Owner.Email);
                userObj.put('username',journey.Owner.Username);
                
                //Add to array
                usersListMap.add(userObj);
            }
            
        }
        
        //Serialize JSON
        String jsonBody = JSON.serialize(usersListMap);
        
        //Invoke Callout
        Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
        
        System.debug('HTTP Response Code: ' + responseCode);        
    }

    global void finish(Database.BatchableContext BC) {
        // Perform finish operations
    }



    // Helper methods to get the start and end date of the quarter
    private Date getStartDate() {
        Date today = Date.today();
        
        Integer currentYear = today.year();
        Integer currentMonth = today.month();
        
        Integer previousQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
        
        if (previousQuarterStartMonth <= 0) {
            previousQuarterStartMonth += 12;
            currentYear--;
        }
        
        Date previousQuarterStartDate = Date.newInstance(currentYear, previousQuarterStartMonth, 1);
        return previousQuarterStartDate;
    }

    private Date getEndDate() {
    Date previousQuarterStartDate = getStartDate();
    Date previousQuarterEndDate = previousQuarterStartDate.addMonths(3).addDays(-1);
        return previousQuarterEndDate;
    }
}