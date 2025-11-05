public class AccountHandler {
    public static Account insertNewAccount(String name) {
        try {
            Account acc = new Account(Name = name);
            insert acc;
            return acc;
        } catch (DmlException e) {
            // Log error if needed: System.debug('DML failed: ' + e.getMessage());
            return null;
        }
    }
}