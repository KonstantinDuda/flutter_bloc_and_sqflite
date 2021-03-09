import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'task_bloc.dart';
import 'task.dart';
import 'provider_bloc.dart';

class UpdatePage extends StatelessWidget {
  final Task updateTask;
  UpdatePage(this.updateTask);

  @override
  Widget build(BuildContext context) {
    print("build update page");
    print("Update Task == ${updateTask.toMap()}");
    return /*BlocBuilder<ProviderBloc, ProviderState> (
      builder: (_, state) => 
    //)
    
    Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body:*/
        BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> tasks;
      if (state is TaskLoadSuccessState) {
        //print('tasks = state.tasks');

        if (state.tasks == null) {
          tasks = [];
          //print('tasks == null; now $tasks');
        } else
          tasks = state.tasks;
      } else {
        //print('tasks = [] because state is not a TaskLoadSuccessState');
        tasks = [];
      }
      print('tasks == $tasks');
      return Scaffold(
        appBar: AppBar(
          title: Text('Update ${updateTask.text}'),
        ),
        body: ListView.builder(
            itemCount:
                tasks.length, //.db.getAllTask().length,//MyDB.db.myDB.length,
            itemBuilder: (context, index) {
              print("ListView.builder");
              return GestureDetector(
                onTap: () {
                  // TODO Нужно запустить эту страницу с таской которую тапнули
                  print(tasks[index].id);
                  print(tasks[index].text);
                },
                onLongPress: () {
                  print("Long press on ${tasks[index].id}");
                  //setState(() { borderColor = Colors.orange; });
                },
                child: Container(
                  //height: MyDB.db.myDB[index].heightContainer,    //62, // Не должно быть константным // Задается в обьекте
                  //width: 500,
                  margin: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: tasks[index] == updateTask
                          ? Colors.orange
                          : Colors.blue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          //color: Colors.red,
                          margin: EdgeInsets.fromLTRB(20.0, 10.0, 5.0, 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text //('${items[index]}'),
                                    //('ggggggggggggg gggggggggggg gggggggggggguhuuuu gghhhhhhh ggggggggg gggggggggggg gggggggggggg gggggggggggguhuuuu gghhhhhhh ggggggggg gggggggggggg gggggggggggg gghhhhhhhhhhhh hhhhhh hhhhh hhhhhh ggggggggg gggggggggggg gggggggggggg gghhhhhhhhhhhh hhhhhh $MyDB',//[index]}',
                                    (
                                  //"$index",
                                  tasks[index]
                                      .text, //TaskDB.db.getTask(index).text,   //MyDB.db.myDB[index].text,
                                  style: tasks[index] == updateTask
                                      ? TextStyle(fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                              LinearPercentIndicator(
                                alignment: MainAxisAlignment.center,
                                width: MediaQuery.of(context).size.width / 2,
                                lineHeight: 3.5,
                                percent: 0.0,
                                leading: Text("0"),
                                //center: Text("50"),
                                trailing: Text("0"), // Задается в обьекте
                                progressColor: Colors.blue,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15.0),
                        //alignment: MainAxisAlignment.center,
                        child: Text("0 / 0"),
                      ),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.baseline,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    BlocProvider.of<ProviderBloc>(context).add(DialogEvent(updateTask));
                  },
                  label: Text('Rewrite'),
                  icon: Icon(Icons.create),
                  backgroundColor: Colors.blue,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: FloatingActionButton(
                  onPressed: () {
                    //BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.dialog);
                    //BlocProvider.of<TaskBloc>(context).add(TaskEvent(Events.updateTask, oldId: updateIndex, newId: updateIndex +1));
                    //newId(1);
                    print('press Bottom');
                    BlocProvider.of<TaskBloc>(context)
                        .add(TaskUpdateEvent(updateTask.id, 1.0, updateTask.text));
                  },
                  child: Icon(Icons.arrow_downward),
                  backgroundColor: Colors.blue,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: FloatingActionButton(
                  onPressed: () {
                    print('press Up');
                    //BlocProvider.of<TaskBloc>(context).add(TaskEvent(Events.updateTask, oldId: updateIndex, newId: updateIndex -1));
                    BlocProvider.of<TaskBloc>(context)
                        .add(TaskUpdateEvent(updateTask.id, -1.0, updateTask.text));
                    //BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.dialog);
                  },
                  child: Icon(Icons.arrow_upward),
                  backgroundColor: Colors.blue,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<ProviderBloc>(context).add(RootEvent());
                  },
                  child: Icon(Icons.check_outlined),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
