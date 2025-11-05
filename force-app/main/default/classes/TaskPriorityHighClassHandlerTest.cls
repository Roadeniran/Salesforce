@isTest
public class TaskPriorityHighClassHandlerTest {
@isTest
    public static void UpdateTaskPriorityTest(){
        //Create a new task record with task set to "Normal"
        Task nt = new Task();
        nt.Priority = 'Normal';
        nt.Status  = 'Not Started';
        nt.Subject = 'Email';
        
        insert nt;
        
        //call the just created record
        Task record = [Select priority FROM task WHERE id=: nt.Id];
        
        //compare result
        system.assert.areEqual('High', record.Priority);
    }

}