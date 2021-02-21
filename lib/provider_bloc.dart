import 'package:flutter_bloc/flutter_bloc.dart';

enum ProviderEvent {rootPage, dialog, update}

//@immutable 
abstract class ProviderState {}

class RootState extends ProviderState {}

class DialogState extends ProviderState {}

class UpdateState extends ProviderState {}

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc() : super(RootState());

  @override 
  Stream<ProviderState> mapEventToState(ProviderEvent event) async* {
    switch (event) {
      case ProviderEvent.rootPage:
        yield RootState();
        break;
      case ProviderEvent.dialog:
        yield DialogState();
        break;
      case ProviderEvent.update:
        yield UpdateState();
        break;
    }
  }
}