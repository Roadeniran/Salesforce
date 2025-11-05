@isTest
public class AccountOwnershipPrivateHandlerTest {

    @isTest
    static void testOwnershipSetToPrivateShouldFail() {
        // Create an Account with non-private ownership
        Account acc = new Account(Name = 'Test Account', Ownership = 'Public');
        insert acc;

        // Update Ownership to Private, which should trigger the error
        acc.Ownership = 'Private';

        Test.startTest();
        try {
            update acc;
            System.assert(false, 'Expected DMLException was not thrown');
        } catch (DmlException e) {
            System.assert(e.getDmlMessage(0).contains('Ownership is set to Private'));
        }
        Test.stopTest();
    }

    @isTest
    static void testOwnershipNotSetToPrivateShouldPass() {
        Account acc = new Account(Name = 'Another Account', Ownership = 'Public');
        insert acc;

        // Change to a different non-private value
        acc.Name = 'Updated Name';

        Test.startTest();
        update acc;
        Test.stopTest();

        // Confirm update went through
        Account updatedAcc = [SELECT Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Updated Name', updatedAcc.Name);
    }
}