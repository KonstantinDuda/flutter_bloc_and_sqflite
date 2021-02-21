//import 'package:bloc_list_builder/my_db.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'task.dart';
//import 'task_db.dart';
import 'task_bloc.dart';
//import 'task_cubit.dart';
//import 'db_controller.dart';
//import 'my_db.dart';
//import 'task_event.dart';
import 'update.dart';
import 'my_dialog.dart';
import 'observer.dart';
import 'provider_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  //DBProvider.db.database;
  //DBController.db.getAllTask();
  //List<Task> list = [];
   runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProviderBloc>(
          create: (context) => ProviderBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(list: new List<Task>())..add(TaskLoadSuccessEvent()),
        ),
        /*BlocProvider(
          create: (context) => TaskCubit(),
        ),*/
      ],
      child: MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<ProviderBloc, ProviderState>(
              builder: (_, state) {
                if(state is RootState) {
                  return MyHomePage();
                } else if(state is DialogState) {
                  return MyDialog();
                } else if(state is UpdateState) {
                  return MyHomePage(); //UpdatePage(1);
                }
              }//=> state is RootState ? HorizontalPage() /*RootPage()*/ : ChackPage(),
            ),
      
      //MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget { 
  //String id;
  final title = 'Flutter Demo Home Page';
  int linearPercentIndicatorWidth;

  getLinearPercentIndicatorWidth(context) => MediaQuery.of(context).size.width / 2;
  setLinearPercentIndicatorWidth(context) => MediaQuery.of(context).size.width / 2;
  //final items = List<String>.generate(100, (i) => "Item $i");

  /*myInit(BuildContext context) {
    //context.read<TaskBloc>().add(TaskEvent(Events.initials));
  }*/

  @override
  Widget build(BuildContext context) {
    /*addtoList();
    print(mylist);*/
    //addElements(context);
    //var list = DBProvider.db.getAllTasks();
    //DBController.db.getAllTask();
    var borderColor = Colors.blue;
    //print("build");
    return /*BlocBuilder</*TaskBloc*/ TaskCubit, List<Task>> (
      builder: (context, state) => */
    //)
    BlocBuilder<TaskBloc, TaskState> (
      builder: (context, state) {
        //print('state == $state');
        List<Task> tasks;
        if (state is TaskLoadSuccessState) {
          //print('tasks = state.tasks');
          if(state.tasks == null) {
            tasks = [];
            //print('tasks == null; now $tasks');
          } else 
            tasks = state.tasks;
        } else {
          //print('tasks = [] because state is not a TaskLoadSuccessState');
          tasks = [];
        }
        print('tasks == $tasks');
        /*final task = (state as TaskLoadSuccessState)
          .tasks
          .firstWhere((element) => element.id != null ? true : false);*/ return
        /*if(state is TaskInitial) {
          //context.read<TaskBloc>().add(TaskEvent(Events.initials));
          BlocProvider.of<TaskBloc>(context).add(TaskEvent(Events.initials));
          return Container ( alignment: Alignment.center,
            child: Center(
              child: SizedBox(
                width: 33,
                height: 33,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,),
              ),
            ),);
        } else if(state is TaskSuccess) { return 
    //)*/
    Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: tasks == [] ? 0 : tasks.length ,//10 ,//state.props.length ,//state.length,//DBController.db.dbController.length, //.db.getAllTask().length,//MyDB.db.myDB.length,
          itemBuilder: (context, index) {
             //print("ListView.builder");
             //context.read<TaskCubit>().getAllTask();
            return GestureDetector(
              onTap: () {
                print(state.props[index]);
                //print(DBController.db.dbController[index].id);
                //print(DBController.db.dbController[index].text);
              },
              onLongPress: () {
                BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.update);
                print('longPress on ${tasks[index]}');
                //setState(() { borderColor = Colors.orange; });
              },
              child: Container(
                //height: MyDB.db.myDB[index].heightContainer,    //62, // Не должно быть константным // Задается в обьекте
                //width: 500,
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded( child:
                    Container(
                  //color: Colors.red,
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: 
                         Text //('${items[index]}'),
                            //('ggggggggggggg gggggggggggg gggggggggggguhuuuu gghhhhhhh ggggggggg gggggggggggg gggggggggggg gggggggggggguhuuuu gghhhhhhh ggggggggg gggggggggggg gggggggggggg gghhhhhhhhhhhh hhhhhh hhhhh hhhhhh ggggggggg gggggggggggg gggggggggggg gghhhhhhhhhhhh hhhhhh $MyDB',//[index]}',
                            ( "${tasks[index].id}  ${tasks[index].text}",
                              //DBController.db.dbController[index].text,
                              //state.props[index].toString(),
                              //'${state.props(index).text}' //TaskDB.db.getTask(index).text,   //MyDB.db.myDB[index].text,
                            ),
                      ),
                      LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        // Переменную ширины нужно брать из блока
                        width: getLinearPercentIndicatorWidth(context), // MediaQuery.of(context).size.width / 2,
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
                ),),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.dialog);
        },
        label: Text('Task'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    ) ;}
      );
  }

  /*addElements(BuildContext context) {
    //var nowWidth = MediaQuery.of(context).size.width;
    List<String> n = [];
    for(int i = 0; i < 100; i++) {
      n.add('');
      for(int j = 0; j < 10*i; j++) {
        n[i] += 'm';
      }
    }
    for(int i = 0; i < 100; i++){
      //var newTask = Task(id: MyDB.db.myDB.length, text: "${n[i]}"/*, widthContainer: nowWidth*/);
      TaskDB.db.addTask("${n[i]}");
    }
  }*/
}
