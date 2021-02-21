/*import 'task.dart';
import 'my_db.dart';

class DBController {
  List<Task> dbController = [];

  DBController._();
  static final DBController db = DBController._();

  getAllTask() async {
    print("task_db getAllTask()");
    dbController = await DBProvider.db.getAllTasks();
    return dbController;
  }

  Task getTask(int id) {
    print("task_db getTask() id == $id");
    //Task task = DBProvider.db.getTask(id);
    return dbController[id];
  }

  addTask(String text) {
    print("task_db addTask() text == $text");
    Task task = Task(id: dbController.length, text: text, allTaskCount: 0, completedTaskCount: 0, completedTaskProcent: 0);
    //newTask(text);
    dbController.add(task);
    //myDB.add(newTask);
    DBProvider.db.newTask(task);
  }

  deleteTask(int id) {
    print("task_db deleteTask() id == $id");
    dbController.removeAt(id);
    //myDB.remove(text);
    DBProvider.db.deleteTask(id);
  }

  updateTask(String newText, int newId, int oldId) {
    print("task_db updateTask() newTask == $newTask");
    if(newId != null) {
      Task task = Task(id: newId, text: dbController[oldId].text, allTaskCount: 0, completedTaskCount: 0, completedTaskProcent: 0);
      dbController.insert(newId, task);
    } else {
      dbController.removeAt(oldId);
      Task task = Task(id: oldId, text: newText, allTaskCount: 0, completedTaskCount: 0, completedTaskProcent: 0);
      dbController.insert(oldId, task);
    }
    //dbController.removeAt(newId);
    //dbController.insert(newTask.id, newTask);
    /*var index = 7;
    myDB.remove(text);
    myDB.insert(index, newTask);*/
    //DBProvider.db.updateTask(newTask);
  }

  newTask(String text) {
    //var list = DBProvider.db.getAllTasks();
    
    Task newTask = Task(id: dbController.length, text: text, allTaskCount: 0, completedTaskCount: 0, completedTaskProcent: 0);
    return newTask;
  }

}*/