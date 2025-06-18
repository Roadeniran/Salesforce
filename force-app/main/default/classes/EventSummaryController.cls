public class EventSummaryController {
    public static Map<String, Integer> getTaskStatusSummary(Id eventPlanId){
        Map<String, Integer> taskStatusSummary = new Map<String, Integer>();
        // Aggregate SOQL query: count tasks grouped by Task_Status__c for a specific Event_Plan__c
        List<AggregateResult> results = [
            SELECT Task_Status__c, COUNT(Id) taskCount
            FROM Event_Task__c
            WHERE Event_Plan__c = :eventPlanId
            GROUP BY Task_Status__c
        ];

        // Populate the map with status as key and count as value
        for (AggregateResult ar : results) {
            // cast in string and integer datatype respectively
            String status = (String) ar.get('Task_Status__c');
            Integer count = (Integer) ar.get('taskCount');
            //put in the method
            taskStatusSummary.put(status, count);
        }
        return taskStatusSummary;
    }
	public Static List<Event_Task__c> getOpenTasks(Id eventPlanId) {
        List<Event_Task__c> openTasks = new List<Event_Task__c>();
        // Write SOQL query to fetch open tasks
        openTasks = [SELECT id , Task_Status__c FROM Event_Task__c
                // Use WHERE to filter tasks by status "Not Started"
                      WHERE Event_Plan__c = :eventPlanId
                      AND Task_Status__c = 'Not Started'
                      // Use ORDER BY to sort tasks by Due_Date__c in descending order
                      ORDER BY Due_Date__c DESC];
        return openTasks;
    }
}