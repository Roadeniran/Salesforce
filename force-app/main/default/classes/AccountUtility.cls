public with sharing class AccountUtility {
    public static Void viewAnnualRevenue() {

        List<Account> accountsList = [
            SELECT  Id,
                    Name,
                    AnnualRevenue
            FROM    Account
        ];
        for (Account acc : accountsList) {
            String acctRev = acc.Name + ' : ' + acc.AnnualRevenue;
            System.debug(acctRev);
        }

    }
}