//import 'package:sqflite/sqflite.dart';

import 'package:equatable/equatable.dart';

import 'task.dart';
//import 'task_db.dart';
//import 'task_event.dart';
//import 'task_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
//import 'db_controller.dart';
import 'my_db.dart';

class TaskState extends Equatable {
  TaskState();

  @override 
  List<Object> get props => [];
}
// Состояние загрузки 
class TaskLoadInProgressState extends TaskState {}

// Состояние успешно загруженных данных
class TaskLoadSuccessState extends TaskState {
  final List<Task> tasks;

  TaskLoadSuccessState([this.tasks]);

  @override 
  List<Object> get props => [tasks];
}

// Состояние ошибки при загрузке
class TaskLoadFailureState extends TaskState {}


// События
class TaskEvent extends Equatable {
  TaskEvent(); 

  @override 
  List<Object> get props => [];
}

// Событие удачной загрузки 
class TaskLoadSuccessEvent extends TaskEvent {}
// Ошибка загрузки
//class TaskLoadFailureEvent extends TaskEvent {}

// Событие добавления обьекта
class TaskAddedEvent extends TaskEvent {
  final String text;

  TaskAddedEvent(this.text);

  @override 
  List<Object> get props => [text];
}

// Событие обновления обьекта
class TaskUpdateEvent extends TaskEvent {
  final Task task;

  TaskUpdateEvent(this.task);

  @override 
  List<Object> get props => [task];
}

// События удаления обьекта
class TaskDeletedEvent extends TaskEvent {
  final Task task;

  TaskDeletedEvent(this.task);

  @override 
  List<Object> get props => [task];
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  //DBProvider db = new DBProvider();
  List<Task> list = [];
  final database = new DBProvider();

  TaskBloc({/*this.db*/this.list}) : super(TaskLoadInProgressState());

  @override 
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if(event is TaskLoadSuccessEvent) {
      yield* _taskLoadedToState();
    } else if(event is TaskAddedEvent) {
      yield* _taskAddedToState(event);
    } else if(event is TaskUpdateEvent) {
      yield* _taskUpdateToState(event);
    } else if(event is TaskDeletedEvent) {
      yield* _taskDeleteToState(event);
    }
  }

  Stream<TaskState> _taskLoadedToState() async* {
    try {
      final dbList = await database.getAllTasks();
      print('_taskLoadedToState(); dbList == $dbList');
      list = dbList;
      yield TaskLoadSuccessState(list);
    } catch (_) {
      yield TaskLoadFailureState();
    }
    //final db = list;
    //print('TaskLoadSuccessEvent to State; db == $db');
    //yield TaskLoadSuccessState(db);
  }

  Stream<TaskState> _taskAddedToState(TaskAddedEvent event) async* {
    if(state is TaskLoadSuccessState) {
      Task task;
      print('_taskAddedToState; list == $list');
      if(list.isEmpty) {
        print('list.isEmpty');
        task = new Task(
          id: 1,
          text: event.text,
          allTaskCount: 0,
          completedTaskCount: 0,
          completedTaskProcent: 1.0,
        );
      } else if(list.length > 0) {
          print('list.length > 0');
          task = new Task(
          id: list[list.length -1].id +1,
          text: event.text,
          allTaskCount: 0,
          completedTaskCount: 0,
          completedTaskProcent: 1.0,
        );
      }
      await database.newTask(task);
      final dbList = await database.getAllTasks();
      list = dbList;
      print('_taskAddedToState(); new List == $list');
      yield TaskLoadSuccessState(list);
      //final List<Task> updateTask = (state as TaskLoadSuccessState).tasks
        //..add(task);
      //list.add(event.task);
      
      //yield TaskLoadSuccessState(updateTask);
      //await db.newTask(event.task);
      
    }
  }

  Stream<TaskState> _taskUpdateToState(TaskUpdateEvent event) async* {
    if(state is TaskLoadSuccessState) {
      final List<Task> updateTask = (state as TaskLoadSuccessState).tasks.map((e) {
        return e.id == event.task.id ? event.task : e;
      }).toList();
      yield TaskLoadSuccessState(updateTask);
      //await db.updateTask(event.task);
      /*var oldTaskId = event.task.id;
      list.remove(list[oldTaskId]);
      list.insert(event.task.id ,event.task);*/
    }
  }

  Stream<TaskState> _taskDeleteToState(TaskDeletedEvent event) async* {
    if(state is TaskLoadSuccessState) {
      final updateTasks = (state as TaskLoadSuccessState)
        .tasks
        .where((element) => element.id != event.task.id)
        .toList();
      yield TaskLoadSuccessState(updateTasks);
      // await db.deleteTask(event.task.id);
      //list.remove(list[event.task.id]);
    }
  }
}















/*enum Events {initials, update, newTask, deleteTask}

class TaskEvent {
  //final Task task;
  final int newId;
  final int oldId;
  final String text;
  final Events status;

  const TaskEvent(this.status, {this.text, /*this.task,*/ this.newId, this.oldId});
}

abstract class TaskState extends Equatable {
  @override 
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskSuccess extends TaskState {
  final List<Task> tasks;

  TaskSuccess({this.tasks});

  @override 
  List<Object> get props => [tasks];
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial());

  List<Task> tasks;

  @override 
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if(event.status == Events.initials) {
      /*List<Task>*/ initial();
      print(tasks);
      yield TaskSuccess(tasks: tasks);
    } else if(event.status == Events.update) {
      await update();
      //return;
    } else if(event.status == Events.newTask) {
      await newTask(event);
      yield TaskSuccess(tasks: tasks);
      //return;
    } else if(event.status == Events.deleteTask) {
      await deleteTask();
      //return;
    }
  }

  initial() {
    var newTask = Task.newTask('text 0',0);
    tasks.add(newTask);//await DBProvider.db.getAllTasks();
    print(tasks);
    return;
  }

  update() {

  }

  newTask(TaskEvent event) {
    //Task.newTask(event.text, tasks.length);
    tasks.add(Task.newTask(event.text, tasks.length));
  }

  deleteTask() {

  }
}*/

/*
enum Events {readAll, addTask, deleteTask, updateTask}

class TaskEvent {
  final Task task;
  final int newId;
  final int oldId;
  final String text;
  final Events status;

  const TaskEvent(this.status, {this.text, this.task, this.newId, this.oldId});
}

class TaskBloc extends Bloc<TaskEvent, List<Task>> {
  TaskBloc() : super(DBController.db.dbController);

  @override 
  Stream<List<Task>> mapEventToState(event) async* {
    if(event.status == Events.readAll) {
      yield DBController.db.getAllTask();
    } else if(event.status == Events.addTask) {
      yield DBController.db.addTask(event.text);  //DBProvider.db.newTask(event.task);
    } else if(event.status == Events.deleteTask) {
      yield DBController.db.deleteTask(event.task.id);
    } else if(event.status == Events.updateTask) {
      yield DBController.db.updateTask(event.text, event.newId, event.oldId);
    }
  }

  /*createTaskFromText(String text) {
    Task newTask = Task.newTask(text);
    DBProvider.db.newTask(newTask);
  }*/
}*/

/*class TaskBloc extends Bloc<TaskEvent, List<Task>> {
  TaskBloc() : super([]);

  @override 
  Stream<List<Task>> mapEventToState(event) async* {
    if(event.status == Events.readAll) {
      yield TaskDB.db.getAllTask();
    } else if(event.status == Events.addTask) {
      yield TaskDB.db.addTask(event.text);
    } else if(event.status == Events.deleteTask) {
      yield TaskDB.db.deleteTask(event.task.id);
    } else if(event.status == Events.updateTask) {
      yield TaskDB.db.updateTask(event.task);
    }
  }
}*/

