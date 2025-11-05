public class CasePriorityByOriginHandler {
    public static void UpdateCasePriority(List<case> nc){
        for (case t : nc){
           if (t.origin == 'phone'){
            t.Priority = 'High';
        } 
            else {
                t.Priority = 'low';
            }
        }
        
    }

}