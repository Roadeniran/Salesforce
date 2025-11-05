public class AccountWebsiteUpdateHandlerClass {
    // For Update of related records, you have to compare new values to old values
    // Thus, you get both Trigger.New and Trigger.oldMap
    public static void UpdateChildRecords(List<Account> AcctList, Map<id,Account> OldMap){
        // List to collect contact to update
        List<contact> contactToUpdate = new List<contact>();
        // Loop through the Accounts
        for (Account acc: AcctList){
            // for every account looped, you get the old values to compare from the oldMap
            Account oldAcc = oldMap.get(acc.Id);
            if (acc.Website != oldAcc.Website){
                // Query the child contact records
                List<Contact> ChildContact = [SELECT id, Website__c FROM contact 
                                             WHERE AccountId = :acc.Id];
                //Update the website field on contact
                for (contact con : ChildContact){
                    con.Website__c = acc.Website;
                    contactToUpdate.add(con);
                }
            }
        }
        if (!contactToUpdate.isEmpty()){
            Update contactToUpdate;
        }
    }

}