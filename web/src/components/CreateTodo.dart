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
  String value;
}

@Component()
class CreateTodoComponent extends UiStatefulComponent<CreateTodoProps, CreateTodoState>{

  @override
  Map getDefaultProps() => (newProps()
    ..todos = new List<Task>()
    ..createTaskFunc = null
  );

  @override
  Map getInitialState() => (newState()
    ..error = null
    ..value = "");

  @override
  render(){
    var createTodoStyle = new Map();
    createTodoStyle["marginBottom"] = "25px";
    var buttonStyle = new Map();
    buttonStyle["marginLeft"] = "10px";
    return (Dom.form()
              ..className="pure-form"
              ..onSubmit= this.handleOnSubmit
              ..onChange= this.handleOnChange
              ..style=createTodoStyle)(
        (Dom.input()
          ..type="text"
          ..placeholder="Task to complete?"
          ..value=this.state.value
          ..ref="createInput")(),
        (Dom.button()
          ..className="pure-button"
          ..style=buttonStyle)("Create")
    );
  }



  dynamic handleOnChange(react.SyntheticFormEvent e){
    InputElement val = this.ref("createInput");
    this.state.value = val.value;
    this.setState(this.state);
  }

  dynamic handleOnSubmit(react.SyntheticFormEvent e){
    e.preventDefault();
    bool isValidTask = true;
    for(var task in this.props.todos){
      if(task.title == this.state.value){
        isValidTask = false;
      }
    }
    if(isValidTask && (this.state.value.isNotEmpty)) {
      var taskTitle = this.state.value;
      int timeStamp = this.props.todos.length+1;
      Task newTask = new Task(timeStamp,title: taskTitle);
      this.props.createTaskFunc(newTask);
      this.state.value = "";
      this.setState(this.state);
    }
    return true;
  }
}