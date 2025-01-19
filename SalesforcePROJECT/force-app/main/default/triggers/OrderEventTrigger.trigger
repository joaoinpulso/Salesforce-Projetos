trigger OrderEventTrigger on Order_Event__e (after insert) {

     // List to hold all cases to be created.
     List<Task> task = new List<Task>();
     // Get queue Id for case owner
     Group queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' AND Type='Queue'];
     // Iterate through each notification.
     for (Order_Event__e event : Trigger.New) {
         if (event.Has_Shipped__c == true) {
             // Create Case to dispatch new team.
             Task tsk = new Task();
             tsk.Priority = 'Medium';
             tsk.Subject = 'Follow up on shipped order 105';
             tsk.OwnerId = event.CreatedById;
             Task.add(tsk);
         }
    }
     // Insert all cases corresponding to events received.
     insert Task;

}