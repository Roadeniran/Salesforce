public class AccountEmployeesHandler {
    public static void setEmployee(List<account> AccList){
        for(Account acct: AccList) {
            if (acct.NumberOfEmployees == null){
        	acct.NumberOfEmployees = 1200;
            }    
    	}
    }

}