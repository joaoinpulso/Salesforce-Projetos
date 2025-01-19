public class TaskUtils {
    public static void remindOwners(List<Opportunity> opptys) {
        List<Task> tasks = new List<Task>();
        for (Opportunity opp : opptys) {
            Task task = new Task(
                Subject = 'Follow-up on Opportunity',
                WhatId = opp.Id,
                OwnerId = opp.OwnerId,
                ActivityDate = Date.today(),
                Status = 'Not Started',
                Priority = 'High'
            );
            tasks.add(task);
        }
        insert tasks;
    }
}