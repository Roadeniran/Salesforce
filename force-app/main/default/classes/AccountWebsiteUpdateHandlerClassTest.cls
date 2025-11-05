@isTest
public class AccountWebsiteUpdateHandlerClassTest {
    
    @isTest
    static void testUpdateChildRecords() {
        // Step 1: Create test data
        Account acc = new Account(Name = 'Test Account', phone = '123463722', Website = 'https://oldwebsite.com');
        insert acc;

        // Create child contact linked to the account
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact',Phone= '123456789', Email= 'rasomo@gmail.com', AccountId = acc.Id);
        insert con;

        // Step 2: Simulate update of the Account's website
        acc.Website = 'https://newwebsite.com';
        update acc;

        // Step 3: Query contact to check
        List<Contact> updatedContacts = [SELECT Id, Website__c FROM Contact
                                        WHERE AccountId = :acc.Id
                                        ];
		
        // Step 5: Assert that the contact's custom website field was updated
        for (contact c : updatedContacts){
        System.assertEquals('https://newwebsite.com', c.Website__c);
    	}
    }
}