public with sharing class EventTaskHealthCheckTriggerHandler {
    public void handlerAfterInsert(List<Event_Task__c> newEventTasks) {
        // Logic for after insert operation
        // Call the updateEventFlags method and pass newEventTasks
        updateEventFlags(newEventTasks);
    }
    public void handlerAfterUpdate(List<Event_Task__c> newEventTasks, Map<Id, Event_Task__c> oldEventTasks) {
        // Logic for after update operation
        // Call the updateEventFlags method and pass newEventTasks
        updateEventFlags(newEventTasks);
    }
    
    public void handlerAfterDelete(List<Event_Task__c> deletedEventTasks) {
        // Logic for after delete operation
        // Call the updateEventFlags method and pass deletedEventTasks with a flag for delete
        updateEventFlags(deletedEventTasks);
    }
    
    private void updateEventFlags(List<Event_Task__c> eventTasks) {
        //collection to store event plans to update
        List<Event_Plan__c> eventPlansToUpdate = new List<Event_Plan__c>();
        // collect eventplanIds for the event task list
        Set<Id> eventPlanIds = new Set<Id>();
        for ( Event_Task__c EventTask : eventTasks) {
            if (EventTask.Event_Plan__c != null){
                eventPlanIds.add(EventTask.Event_Plan__c);
            }
        }
        
        // create a list to collect completed task counts for the event plans
        List<AggregateResult> TaskCompleted = [ SELECT  Event_Plan__c, Count(Id) completedCount
                                              FROM Event_Task__c
                                              WHERE Event_Plan__c IN: eventPlanIds
                                              AND Task_Status__c = 'Completed'
                                               GROUP BY Event_Plan__c
                                              ];
        
        List<AggregateResult> TaskTotal = [ SELECT  Event_Plan__c, Count(Id) TaskTotalCount
                                              FROM Event_Task__c
                                              WHERE Event_Plan__c IN: eventPlanIds
                                               GROUP BY Event_Plan__c
                                              ];
        
        // create a map with eventplan Id as key and completed task count as value
        Map<Id, Integer> eventPlanCompletedTaskCount = new Map<Id, Integer>();
        Map<id, Integer>  eventPlanTotalTaskCount = new Map<Id, Integer>();
        
        // Cast and put in map for each event plan
        for (AggregateResult ar : TaskCompleted) {
            eventPlanCompletedTaskCount.put((Id)ar.get('Event_Plan__c'), (Integer)ar.get('completedCount'));
        }
        for (AggregateResult ar : TaskTotal) {
            eventPlanTotalTaskCount.put((Id)ar.get('Event_Plan__c'), (Integer)ar.get('TaskTotalCount'));
        }

        // create list of event plans with event date
        List<Event_Plan__c> eventPlanwtDate = [SELECT Id, Event_Date__c
                                             FROM Event_Plan__c
                                             WHERE Id IN: eventPlanIds
                                             AND Event_Date__c != NULL];
                                            
        // Loop through the event plan with date to cast the datetime to date
        for (Event_Plan__c eventPlan : eventPlanwtDate){
            date eventdate = date.newinstance(eventPlan.Event_Date__c.year(), eventPlan.Event_Date__c.month(), eventPlan.Event_Date__c.day());

            integer CompletedCount = eventPlanCompletedTaskCount.get(eventPlan.Id) != NULL ? eventPlanCompletedTaskCount.get(eventPlan.Id) : 0;
            integer TotalCount = eventPlanTotalTaskCount.get(eventPlan.Id) != NULL ? eventPlanTotalTaskCount.get(eventPlan.Id) : 0;

            decimal percentageCompleted = 0; // create decimal to hold percentage value

            if (TotalCount > 0){
                 percentageCompleted = decimal.valueOf(CompletedCount*100/TotalCount);
            }
            // LOGIC TO UPDATE THE FLAG for the event plan
            If(eventDate<=System.today().addDays(7) && percentageCompleted<50.0)
            {
                eventPlan.Event_Flag__c= 'Critical';
            }
            else if(percentageCompleted==100.0)
            {
                eventPlan.Event_Flag__c = 'Completed';
            }
            else
            {
                eventPlan.Event_Flag__c = 'On Track';
            }
            
            eventPlansToUpdate.add(eventPlan);  
        }
        if(eventPlansToUpdate.size()> 0){
            update eventPlansToUpdate;
        }
    }
}