import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'provider_bloc.dart';
import 'task_bloc.dart';
import 'task.dart';
//import 'task_cubit.dart';

class MyDialog extends StatelessWidget {
  //final textDialog = TextEditingController();
  
  final Task task;
  MyDialog(this.task);
  /*int id = 0;

  newId() {
    id++;
    return id;
  }*/

  @override
  Widget build(BuildContext context) {
    String newText = '';
    if(task != null) {
      newText = task.text;
      print('Text in myDialog ${task.text.length}');
    }
    
    return Card(
      child: Row(
        children: <Widget>[
          Expanded ( child:
          Container(
            //color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Theme.of(context).primaryColor,),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10), //EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child:  
              TextField(
                onChanged: (value) => newText = value,
                controller: TextEditingController(text: newText),
                cursorColor: Colors.black,
                expands: true,
                style: Theme.of(context).textTheme.headline6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                autofocus: true,
              ),
            ),
          ),),
          VerticalDivider(width: 5.0,),
          Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  //margin: EdgeInsets.fromLTRB(0, 2.5, 2.5, 2.5),
                  height: MediaQuery.of(context).size.height * 0.29,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Theme.of(context).primaryColor,),
                  //color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                onTap: () {
                  print("Go to the Root Page");
                  if(task == null) {
                    BlocProvider.of<TaskBloc>(context).add(TaskAddedEvent(newText));
                    BlocProvider.of<ProviderBloc>(context).add(RootEvent());
                  } else {
                    BlocProvider.of<TaskBloc>(context).add(TaskUpdateEvent(task.id, 0, newText));
                    BlocProvider.of<ProviderBloc>(context).add(UpdateEvent(task));
                  }
                },
              ),
              Divider(height: 5.0,),
              GestureDetector(
                child: Container(
                  //margin: EdgeInsets.fromLTRB(0, 2.5, 2.5, 2.5),
                  height: MediaQuery.of(context).size.height * 0.29,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Theme.of(context).primaryColor,),
                  //color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                onTap: () {
                  BlocProvider.of<ProviderBloc>(context).add(RootEvent());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}