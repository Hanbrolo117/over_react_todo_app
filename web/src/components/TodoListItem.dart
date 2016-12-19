import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';

@Factory()
UiFactory<TodoListItemProps> TodoListItem;

@Props()
class TodoListItemProps extends UiProps{
  Task task;
  List<Task> todos;
  var deleteTask;
  var toggleTaskCompletion;
  var saveTask;
}

@State()
class TodoListItemState extends UiState{
  bool isEditing;
  String editValue;
}

@Component()
class TodoListItemComponent extends UiStatefulComponent<TodoListItemProps,TodoListItemState>{

  @override
  Map getDefaultProps() => (newProps()..task = null);

  @override
  Map getInitialState() =>(newState()..isEditing = false);

  ReactElement renderTaskSection(){
    //Create Color Style Red if not completed, Green if completed:
    //---------------------------------------------------------------
    var taskStyle = new Map();
    if(this.props.task.isCompleted){
      taskStyle["color"] = "green";
    }else{
      taskStyle["color"] = "red";
    }
    //---------------------------------------------------------------

    //Generate Task Label Or Edit box (if state is editing):
    //---------------------------------------------------------------
    if(this.state.isEditing){
      return Dom.td()(
          Dom.form()(
              (Dom.input()
                ..type="text"
                ..defaultValue=this.props.task.title
                ..onChange=this.handleOnEditChange
                ..ref="editInput")()
          )
      );
    }
    return (Dom.td()
      ..style=taskStyle
      ..onClick=this.handleTaskCompletion
      )(this.props.task.title);
    //---------------------------------------------------------------
  }


  ReactElement renderActionSection(){

    var buttonStyle = new Map();
    buttonStyle["margin"] = "5px";
    if(this.state.isEditing){
      return Dom.td()(
          (Dom.button()
            ..className="pure-button pure-button-primary"
            ..style=buttonStyle
            ..onClick=this.handleSave)("Save"),
          (Dom.button()
            ..className="pure-button"
            ..style=buttonStyle
            ..onClick=this.toggleEdit)("Cancel")
      );
    }

    return Dom.td()(
        (Dom.button()
          ..className="pure-button"
          ..style=buttonStyle
          ..onClick=this.toggleEdit)("Edit"),
        (Dom.button()
          ..className="button-warning pure-button"
          ..style=buttonStyle
          ..onClick=this.handleDelete)("Delete")
    );

  }

  @override
  render(){
    return Dom.tr()(
        this.renderTaskSection(),
        this.renderActionSection()
    );
  }

  dynamic handleTaskCompletion(react.SyntheticMouseEvent e){
    this.props.toggleTaskCompletion(this.props.task.title);
    return true;
  }

  dynamic handleDelete(react.SyntheticMouseEvent e){
    this.props.deleteTask(this.props.task.title);
    return true;
  }

  dynamic toggleEdit(react.SyntheticMouseEvent e){
    this.state.isEditing = !this.state.isEditing;
    this.setState(this.state);
  }

  dynamic handleOnEditChange(react.SyntheticFormEvent e){
    InputElement inputVal = this.ref("editInput");
    if(inputVal == null){return true;}

    this.state.editValue = inputVal.value;
    this.setState(this.state);
  }

  dynamic handleSave(react.SyntheticMouseEvent e){
    bool isValidTask = true;
    for(var task in this.props.todos){
      if(task.title == this.state.editValue){
        isValidTask = false;
      }
    }
    if(isValidTask && (this.state.editValue.isNotEmpty)) {
      this.props.task.setTitle(this.state.editValue);
      this.props.saveTask(this.props.task.title, this.props.task);
      this.state.isEditing = !this.state.isEditing;
      this.setState(this.state);
    }
    return true;
  }

}