import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';

///Use 'CreateTodo' component to render a form
///for creating a new [Task] object.
@Factory()
UiFactory<CreateTodoProps> CreateTodo;

@Props()
class CreateTodoProps extends UiProps{
  ///The List of [Task]s that a new task this component
  ///creates would insert into.
  ///
  /// Initial: new List<Task>
  List<Task> todos;

  ///A function that inserts the newly created [Task] object
  ///into the list of tasks.
  ///
  /// Initial: null
  var createTaskFunc;
}

@State()
class CreateTodoState extends UiState{
  ///Value for displaying a warning message if user input
  ///is invalid.
  ///
  /// Initial: null
  var error;

  ///Value for acting as the "source of truth" for the user input
  ///for the [Task.title] value.
  ///
  /// Initial: ""
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
          ..ref="createInput"
        )(),
        (Dom.button()
          ..className="pure-button"
          ..style=buttonStyle
        )("Create")
    );
  }


  ///This is an Event Handler for when the editInput inputElement
  ///is updated by the user. This function then updates this
  ///component's own copy of the inputElement's value which lives
  ///in it's state, [this.state.value].
  dynamic handleOnChange(react.SyntheticFormEvent e){
    InputElement val = this.ref("createInput");
    this.state.value = val.value;
    this.setState(this.state);
  }

  ///THis is an Event Handler for when a user submits this components form,
  ///the root ReactElement of this component. If the data the user inputted is
  ///valid, it calls [this.props.createTaskFunc] to add a new [Task] to the
  ///app's task list.
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