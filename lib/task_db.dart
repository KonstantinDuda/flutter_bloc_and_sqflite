/*import 'task.dart';
import 'my_db.dart';

class TaskDB {
  //List<Task> myDB = [];

  TaskDB._();
  static final TaskDB db = TaskDB._();

  getAllTask() async {
    print("task_db getAllTask()");
    List<Task> list = await DBProvider.db.getAllTasks();
    return list;
  }

  getTask(int id) {
    print("task_db getTask() id == $id");
    Task task = DBProvider.db.getTask(id);
    return task;
  }

  addTask(String text) {
    print("task_db addTask() text == $text");
    Task task = newTask(text);
    //myDB.add(newTask);
    DBProvider.db.newTask(task);
  }

  deleteTask(int id) {
    print("task_db deleteTask() id == $id");
    // TODO change text on the Task
    //myDB.remove(text);
    DBProvider.db.deleteTask(id);
  }

  updateTask(Task newTask) {
    // TODO find correct index
    print("task_db updateTask() newTask == $newTask");
    /*var index = 7;
    myDB.remove(text);
    myDB.insert(index, newTask);*/
    DBProvider.db.updateTask(newTask);
  }

  newTask(String text) {
    //var list = DBProvider.db.getAllTasks();
    
    Task newTask = Task(id: 0, text: text, allTaskCount: 0, completedTaskCount: 0, completedTaskProcent: 0);
    return newTask;
  }

}*/