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

        // Populate the map with status as key and count as values
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
    public Static Map<String, Decimal> getExpensesByCategory(Id eventPlanId) {
        Map<String, Decimal> expensesByCategory = new Map<String, Decimal>();
        // Write SOQL query and aggregate function here
        // Use GROUP BY to group results by Category__c
        // Use SUM() to calculate total expenses
        List<AggregateResult> results = [SELECT Category__c, SUM(Amount__c) totalExpense
                FROM Event_Expense__c
                WHERE Associated_Event__c = :eventPlanId
                GROUP BY Category__c];
                // Cast Category__c and totalExpense from the AggregatedResult object and put them)
                for (AggregateResult ar : results) {
                    string categoryName = (String) ar.get('Category__c');
                    decimal totalExpenses = (decimal) ar.get('totalExpense');
                    expensesByCategory.put(categoryName, totalExpenses);
                }  
        return expensesByCategory;
    }
    public Static Event_Expense__c getMostExpensiveExpense(Id eventPlanId) {
        Event_Expense__c mostExpensiveExpense = 
            // Write SOQL query here
        // Use ORDER BY to sort expenses by Amount__c in descending order
        // Use LIMIT to retrieve only one record
        [SELECT Name, Category__c, Amount__c, Associated_Event__c FROM Event_Expense__c
        WHERE Associated_Event__c = :eventPlanId
        ORDER BY Amount__c DESC
        LIMIT 1];
        return mostExpensiveExpense;
    }
}
