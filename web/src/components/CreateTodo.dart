import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';

@Factory()
UiFactory<CreateTodoProps> CreateTodo;

@Props()
class CreateTodoProps extends UiProps{
  List<Task> todos;
  var createTaskFunc;
  String title;
}

@State()
class CreateTodoState extends UiState{
  var error;
}

@Component()
class CreateTodoComponent extends UiStatefulComponent<CreateTodoProps, CreateTodoState>{

  @override
  Map getDefaultProps() => (newProps()
    ..todos = new List<Task>()
    ..createTaskFunc = null
  );

  @override
  Map getInitialState() => (newState()..error = null);

  @override
  render(){

    return (Dom.form()
              ..className="createTaskForm"
              ..onSubmit=this.props.createTaskFunc)(
        (Dom.input()
          ..type="text"
          ..placeholder="Task to complete?"
          ..ref="createInput")(),
        Dom.button()("Create")
    );
  }


  void handleOnChange(){

  }
}