public class TaskPriorityHighClassHandler {
    public static void UpdateTaskPriority(List<Task> newTask){
        for (Task t : newTask) {
        t.Priority = 'High'; // Directly update the Priority field
    }
    }
}