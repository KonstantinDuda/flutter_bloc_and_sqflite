/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

//import 'task_bloc.dart';
import 'task.dart';
//import 'task_cubit.dart';
//import 'db_controller.dart';
import 'provider_bloc.dart';

class UpdatePage extends StatelessWidget { 
  int updateIndex;
  UpdatePage(this.updateIndex);

  //int get updateId => updateIndex;
  /*newId(int i) {
    if(updateIndex > 0 || updateIndex < DBController.db.dbController.length - 1) {
      updateIndex += i;
    } else if(updateIndex == 0) {
      updateIndex = 0;
    } else if(updateIndex >= DBController.db.dbController.length - 1) {
      updateIndex = DBController.db.dbController.length - 1;
    }
    
  }*/

  @override
  Widget build(BuildContext context) {
    
    print("build update page");
    return BlocBuilder<ProviderBloc, ProviderState> (
      builder: (_, state) => 
    //)
    
    Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body: BlocBuilder<TaskCubit, List<Task>> (
        builder: (_, state) =>
      
      ListView.builder(
          itemCount: DBController.db.dbController.length, //.db.getAllTask().length,//MyDB.db.myDB.length,
          itemBuilder: (context, index) {
             print("ListView.builder");
            return GestureDetector(
              onTap: () {
                print(DBController.db.dbController[index].id);
                print(DBController.db.dbController[index].text);
              },
              onLongPress: () {
                print("Long press on ${DBController.db.dbController[index].id}");
                //setState(() { borderColor = Colors.orange; });
              },
              child: Container(
                //height: MyDB.db.myDB[index].heightContainer,    //62, // Не должно быть константным // Задается в обьекте
                //width: 500,
                margin: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: index == updateIndex ? Colors.orange : Colors.blue,
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
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 5.0, 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: 
                         Text //('${items[index]}'),
                            //('ggggggggggggg gggggggggggg gggggggggggguhuuuu gghhhhhhh ggggggggg gggggggggggg gggggggggggg gggggggggggguhuuuu gghhhhhhh ggggggggg gggggggggggg gggggggggggg gghhhhhhhhhhhh hhhhhh hhhhh hhhhhh ggggggggg gggggggggggg gggggggggggg gghhhhhhhhhhhh hhhhhh $MyDB',//[index]}',
                            ( //"$index",
                              DBController.db.dbController[index].text, //TaskDB.db.getTask(index).text,   //MyDB.db.myDB[index].text,
                              style: index == updateIndex ? TextStyle(fontWeight: FontWeight.bold) : TextStyle(fontWeight: FontWeight.normal),
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
          }),),
      floatingActionButton: Container ( 
        child: Row (
          mainAxisAlignment: MainAxisAlignment.end,
          //crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget> [
          Container ( 
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: FloatingActionButton.extended(
        onPressed: () {
          BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.dialog);
          
        },
        label: Text('Rewrite'),
        icon: Icon(Icons.create),
        backgroundColor: Colors.blue,
      ),),
      Container ( 
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: FloatingActionButton(
        onPressed: () {
          //BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.dialog);
          //BlocProvider.of<TaskBloc>(context).add(TaskEvent(Events.updateTask, oldId: updateIndex, newId: updateIndex +1));
          newId(1);
        },
        child: Icon(Icons.arrow_downward),
        backgroundColor: Colors.blue,
      ),),
      Container ( 
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: FloatingActionButton(
        onPressed: () {
          //BlocProvider.of<TaskBloc>(context).add(TaskEvent(Events.updateTask, oldId: updateIndex, newId: updateIndex -1));
          newId(-1);
          //BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.dialog);
        },
        child: Icon(Icons.arrow_upward),
        backgroundColor: Colors.blue,
      ),),
      Container ( 
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.rootPage);
        },
        child: Icon(Icons.check_outlined),
        backgroundColor: Colors.blue,
      ),),
        ]
      ),
    ),),
    );
    }
  }*/