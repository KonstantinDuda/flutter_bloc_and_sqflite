import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'provider_bloc.dart';
import 'task_bloc.dart';
import 'task.dart';
//import 'task_cubit.dart';

class MyDialog extends StatelessWidget {
  final textDialog = TextEditingController();
  int id = 0;

  newId() {
    id++;
    return id;
  }

  @override
  Widget build(BuildContext context) {
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
                controller: textDialog,
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
                  BlocProvider.of<TaskBloc>(context).add(TaskAddedEvent(textDialog.text));
                  //context.read<TaskBloc>().add(TaskAddedEvent(Task.newTask(textDialog.text, newId())));
                  //context.read<TaskBloc>().add(TaskEvent(Events.newTask, text: textDialog.text));
                  //BlocProvider.of<TaskBloc>(context).add(TaskEvent(Events.addTask , text: textDialog.text));
                  //context.read<TaskCubit>().addTask(textDialog.text);
                  BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.rootPage);
                  
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
                  BlocProvider.of<ProviderBloc>(context).add(ProviderEvent.rootPage);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}