import 'package:equatable/equatable.dart';

import 'task.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
//import 'my_db.dart';

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
  final int id;
  final int newPosition;
  final String newText;

  TaskUpdateEvent(this.id, this.newPosition, this.newText);

  @override 
  List<Object> get props => [id, newPosition, newText];
}

// События удаления обьекта
class TaskDeletedEvent extends TaskEvent {
  final int id;

  TaskDeletedEvent(this.id);

  @override 
  List<Object> get props => [id];
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  
  List<Task> list = [];
  //final database = new DBProvider();

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
      //final dbList = await database.getAllTasks();
      final dbList = list;
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
          position: 1,
          text: event.text,
          allTaskCount: 0,
          completedTaskCount: 0,
          completedTaskProcent: 1.0,
        );
      } else if(list.length > 0) {
          print('list.length > 0');
          task = new Task(
          id: list[list.length -1].id +1,
          position: list.last.position +(1),
          text: event.text,
          allTaskCount: 0,
          completedTaskCount: 0,
          completedTaskProcent: 1.0,
        );
      }
      print("task.position == ${task.position}");
      //await database.newTask(task);
      //final dbList = await database.getAllTasks();
      //list = dbList;
      list.add(task);
      list.sort((a,b) => a.position.compareTo(b.position));
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
    // TODO не правильно расчитывает позицию

    Task updateTask;
    int updateTaskIndex;
    
    for(int i = 0; i < list.length; i++) {
      if(list[i].id == event.id) {
        print("if(list[i].id == event.id)");
        updateTask = list[i];
        updateTaskIndex = i;
      }
    }
    if(event.newPosition == 0){
      print("if(event.newPosition == 0)");
      updateTask.text = event.newText;
    } else if(event.newPosition > 0) {
      print("if(event.newPosition > 0)");
      if((list[updateTaskIndex].position + event.newPosition) >= list.length) {
        print("if((list[updateTaskIndex].position + event.newPosition) >= list.length)");
        for(int i = 0; i < list.length; i++) {
          if(list[i].position > updateTask.position) {
            list[i].position -= 1;
          }
        }
        updateTask.position = list.length;
      } else {
        print("else");
      for(int i = 0; i < list.length; i++) {
          if(list[i].position > updateTask.position && list[i].position <= 
          (updateTask.position + event.newPosition)) {
            print("if(list[i].position > updateTask.position && list[i].position < (updateTask.position + event.newPosition))");
            list[i].position -= 1;
          }
        }
      updateTask.position += event.newPosition;
      }
    } else if(event.newPosition < 0) {
      print("if(event.newPosition < 0)");
      if((list[updateTaskIndex].position + event.newPosition) <= 1) {
        print("if((list[updateTaskIndex].position - event.newPosition) < 1)");
        for(int i = 0; i < list.length; i++) {
          if(list[i].position < updateTask.position) {
            list[i].position += 1;
          }
        }
        updateTask.position = 1;
      } else {
      for(int i = 0; i < list.length; i++) {
        if(list[i].position < updateTask.position && list[i].position >= 
          (updateTask.position + event.newPosition)) {
            print("if(list[i].position < updateTask.position && list[i].position > (updateTask.position + event.newPosition))");
            list[i].position += 1;
          }
      }
      updateTask.position += event.newPosition;
    }
    }
    list[updateTaskIndex] = updateTask;

    list.sort((a,b) => a.position.compareTo(b.position));
    for(Task element in list) {
      print("element = ${element.toMap()}");
    }
    yield TaskLoadInProgressState();
    yield TaskLoadSuccessState(list);


    /*double pre = 0.0;
    double post = 0.0;
    Task updateTask;
    int updateTaskIndex;

    if(event.newPosition == 0.0) {
      print("event newPosition == 0.0");
      for(int i = 0; i < list.length; i++) {
        if(event.id == list[i].id) {
          list[i].text = event.newText;
          for(Task element in list) {
            print(element.toMap());
          }
          yield TaskLoadSuccessState(list);
        }
      }

    } else if(event.newPosition == -1.0) {
      print("event newPosition == -1.0");
      for(int i = 0; i < list.length; i++) {
        if(list[i].id == event.id) {
          updateTask = list[i];
          updateTaskIndex = i;
        }
      }
      print("updateTask == ${updateTask.toMap()}");
      print("updateTaskIndex == $updateTaskIndex");
      if(list.length <= 1 || updateTask == list.first) {
        print("list.length <= 1 || updateTask == list.first");
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      } else if(list.length == 2) {
        print("list.length == 2");
        if(updateTaskIndex == 0) {
          print("updateTaskIndex == 0");
          yield TaskLoadInProgressState();
          yield TaskLoadSuccessState(list);
        } else {
          print("else updateTaskIndex == 0");
          updateTask.position = list[0].position / 2;
          list[updateTaskIndex] = updateTask;
          list.sort((a,b) => a.position.compareTo(b.position));
          yield TaskLoadInProgressState();
          yield TaskLoadSuccessState(list);
        }
      } else if(updateTask == list[1]) {
        print("updateTask == list[1]");
        updateTask.position = list[0].position / 2;
        list[updateTaskIndex] = updateTask;
        list.sort((a,b) => a.position.compareTo(b.position));
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      } else {
        print("else list.length == 2");
        post = list[updateTaskIndex - 1].position;
        pre = list[updateTaskIndex - 2].position;

        print("pre == $pre");
        print("post == $post");
    
        updateTask.position = (post + pre) / 2;
        list[updateTaskIndex] = updateTask;

        list.sort((a,b) => a.position.compareTo(b.position));
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      }


      /*for(Task element in list) {
        if(element.position < updateTask.position && element.position > post) {
          post = element.position;
        } else {
          post = updateTask.position;
        }
      }
      for(Task element in list) {
        if(element.position < post && element.position > pre) {
          pre = element.position;
        } else {
          post = updateTask.position;
        }
      }*/
    } else if(event.newPosition == 1.0) {
      print("event newPosition == +1.0");
      for(int i = 0; i < list.length; i++) {
        if(list[i].id == event.id) {
          updateTask = list[i];
          updateTaskIndex = i;
        }
      }
      print("updateTask == ${updateTask.toMap()}");
      print("updateTaskIndex == $updateTaskIndex");
      if(list.length <= 1 || updateTask == list.last) {
        print("list.length <= 1 || updateTask == list.last");
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      } else if(list.length == 2) {
        print("list.length == 2");
        if(updateTaskIndex > 0) {
          print("updateTaskIndex > 0");
          yield TaskLoadInProgressState();
          yield TaskLoadSuccessState(list);
        } else {
          print("else updateTaskIndex > 0");
          updateTask.position = list.last.position + 1.0;
          list[updateTaskIndex] = updateTask;
          list.sort((a,b) => a.position.compareTo(b.position));
          yield TaskLoadInProgressState();
          yield TaskLoadSuccessState(list);
        }
        updateTask.position = list[list.length - 1].position + 1;
        list.sort((a,b) => a.position.compareTo(b.position));
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      } else if(updateTask == list[list.length - 2]) {
        print("updateTask == ${list[list.length - 2].toMap()}");
        updateTask.position = list[list.length -1].position + 1.0;
        list[updateTaskIndex] = updateTask;
        list.sort((a,b) => a.position.compareTo(b.position));
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      } else {
        print("else updateTask == list[list.length - 2]");
        pre = list[updateTaskIndex + 1].position;
        post = list[updateTaskIndex + 2].position;

        print("pre == $pre");
        print("post == $post");
    
        updateTask.position = (post + pre) / 2;
        list[updateTaskIndex] = updateTask;

        list.sort((a,b) => a.position.compareTo(b.position));
        yield TaskLoadInProgressState();
        yield TaskLoadSuccessState(list);
      }

      /*for(Task element in list) {
        pre = list.last.position;
        if(element.position > updateTask.position && element.position < pre) {
          pre = element.position;
        } else {
          pre = updateTask.position;
        }
      }
      for(Task element in list) {
        if(element.position > updateTask.position && element.position > post) {
          post = element.position;
        } else {
          post = updateTask.position;
        }
      }*/
    }

    /*print("pre == $pre");
    print("post == $post");
    
    updateTask.position = (post + pre) / 2;
    list[updateTaskIndex] = updateTask;
    list.sort((a,b) => a.position.compareTo(b.position));*/
    for(Task element in list) {
      print("element = ${element.toMap()}");
    }*/
    /*yield TaskLoadInProgressState();
    yield TaskLoadSuccessState(list);*/
    
  }

  Stream<TaskState> _taskDeleteToState(TaskDeletedEvent event) async* {
    if(state is TaskLoadSuccessState) {
      print("_taskDeleteToState; state is TaskLoadSuccessState");
      final listNew = (state as TaskLoadSuccessState).tasks;
      for (var i = 0; i < listNew.length; i++) {
      if(listNew[i].id == event.id) {
        listNew.removeAt(i);
        print("listNew[i].id == event.id");
      }
    }
    listNew.sort((a,b) => a.position.compareTo(b.position));
    for(Task element in list) {
      print("new element == ${element.toMap()}");
    }
    //print('_taskDeleteToState(); new List[i] == $listNew');
    yield TaskLoadInProgressState();
    yield TaskLoadSuccessState(listNew);
    list = listNew;
    }
    /*var newList = list;
    for (var i = 0; i < newList.length; i++) {
      if(newList[i].id == event.id) {
        newList.removeAt(i);
      }
    }
    newList.sort((a,b) => a.position.compareTo(b.position));
    
    print('_taskAddedToState(); new List == $list');
    yield TaskLoadSuccessState(newList);
    list = newList;*/

    /*if(state is TaskLoadSuccessState) {
      final updateTasks = (state as TaskLoadSuccessState)
        .tasks
        .where((element) => element.id != event.task.id)
        .toList();
      yield TaskLoadSuccessState(updateTasks);
      // await db.deleteTask(event.task.id);
      //list.remove(list[event.task.id]);
    }*/
  }
}