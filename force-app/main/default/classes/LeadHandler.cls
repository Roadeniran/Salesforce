public with sharing class LeadHandler {
    public static void UpdateLeadStatus(list<lead> leadlist) {
        for (lead l: leadlist){
           // set status to working contacted 
                l.status = 'Working - Contacted'; 
            }
                
    }
}