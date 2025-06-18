trigger EventTaskHealthCheckTrigger on Event_Task__c (after insert, After update, After delete) {
if (Trigger.isAfter) {
        EventTaskHealthCheckTriggerHandler handler = new EventTaskHealthCheckTriggerHandler();
        
        if(Trigger.isInsert){
            handler.handlerAfterInsert(Trigger.new); // Passing All the New Values Quickly in a Newly Created Record Function
        }
        else if(Trigger.isUpdate){
            handler.handleAfterUpdate(Trigger.new, trigger.oldMap);// Passing All the Updated Records Along with Old records inside the After Update Function
        }
        else if(Trigger.isDelete){
            handler.handleafterDelete(Trigger.old); //Passing all the Deleted Records Inside The After Deletion Function
        }
    }

}