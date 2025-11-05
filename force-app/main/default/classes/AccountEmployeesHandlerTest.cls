@isTest
public class AccountEmployeesHandlerTest {

    @isTest
    static void testSetEmployeeWhenNumberIsNull() {
        // Create an account without NumberOfEmployees
        Account acc = new Account(Name = 'Test Account');

        Test.startTest();
        insert acc;
        Test.stopTest();

        // Query to verify the update
        Account result = [SELECT Id, NumberOfEmployees FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1200, result.NumberOfEmployees);
    }

    @isTest
    static void testSetEmployeeWhenNumberIsNotNull() {
        // Create an account with NumberOfEmployees
        Account acc = new Account(Name = 'Preset Account', NumberOfEmployees = 500);

        Test.startTest();
        insert acc;
        Test.stopTest();

        // Confirm it retains its original value
        Account result = [SELECT Id, NumberOfEmployees FROM Account WHERE Id = :acc.Id];
        System.assertEquals(500, result.NumberOfEmployees);
    }
}