public class NoParentAcconContactHandler {
    public static void ParentCheck(List<Contact> con){
        for (contact c : con){
            if (c.AccountId == null){
                c.AccountId.addError('Contact must have a parent account');
            }
        }
        
    }
}