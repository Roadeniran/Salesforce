@isTest
public class NoParentAcconContactHandlerTest {

 @isTest
  // Case 1 without a parent account
    static void case1() {
        Contact c = new Contact(FirstName = 'Test', LastName = 'NoAccount');

        try {
            insert c;
            System.assert(false, 'Insert should have failed');
        } catch (DmlException e) {
            System.assertEquals(e.getMessage(),'Contact must have a parent account');
        }
    }

    @isTest
// Case 2 with a parent account
    static void case2() {
        Account acc = new Account(Name = 'Valid Account');
        insert acc;

        Contact c = new Contact(FirstName = 'Test', LastName = 'WithAccount', AccountId = acc.Id);

        insert c;

        Contact result = [SELECT Id, AccountId FROM Contact WHERE Id = :c.Id];
        System.assertEquals(acc.Id, result.AccountId);
    }
}