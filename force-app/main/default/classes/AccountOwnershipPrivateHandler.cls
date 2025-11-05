public class AccountOwnershipPrivateHandler {
    public static void OwnershipValidation(List<Account> OldValues){
        for (Account acc : OldValues){
            if (acc.Ownership == 'Private'){
                acc.addError('Ownership is set to Private, Can\'t update this record');
            }
        }
    }

}