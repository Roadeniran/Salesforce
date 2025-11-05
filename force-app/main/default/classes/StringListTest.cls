public class StringListTest {
    public static List<string> generateStringList(integer n){
        List<string> Test = new List<string>();
        for (integer i=0; i<n; i++) {
            Test.add('Test '+i);
        }
        system.debug(Test);
        return Test;
    }
    
}