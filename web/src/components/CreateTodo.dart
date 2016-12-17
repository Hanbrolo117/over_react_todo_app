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
    var createTodoStyle = new Map();
    createTodoStyle["marginBottom"] = "25px";
    var buttonStyle = new Map();
    buttonStyle["marginLeft"] = "10px";
    return (Dom.form()
              ..className="pure-form"
              ..onSubmit=this.props.createTaskFunc
              ..style=createTodoStyle)(
        (Dom.input()
          ..type="text"
          ..placeholder="Task to complete?"
          ..ref="createInput")(),
        (Dom.button()
          ..className="pure-button"
          ..style=buttonStyle)("Create")
    );
  }


  void handleOnChange(){

  }
}