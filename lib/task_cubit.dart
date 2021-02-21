/*import 'package:bloc/bloc.dart';
import 'task.dart';
import 'db_controller.dart';
//import 'my_db.dart';

class TaskCubit extends Cubit<List<Task>> {
  TaskCubit() : super(DBController.db.dbController);

  /*getAllTask() {
    //DBController.db.getAllTask();
    state.addAll(DBController.db.getAllTask());
    emit(state);
  }*/

  addTask(String value) {
    //state.add(Task.newTask(value));
    DBController.db.addTask(value);
    emit(DBController.db.dbController);//DBController.db.newTask(value));
  }
  
  deleteTask(int id) {
    state.removeAt(id);
    DBController.db.deleteTask(id);
    emit(DBController.db.dbController);
  }
    
}*/