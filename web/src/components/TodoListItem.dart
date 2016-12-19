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
  var deleteTask;
  var toggleTaskCompletion;
}

@State()
class TodoListItemState extends UiState{
  bool isEditing;
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
            ..style=buttonStyle)("Save"),
          (Dom.button()
            ..className="pure-button"
            ..style=buttonStyle)("Cancel")
      );
    }

    return Dom.td()(
        (Dom.button()
          ..className="pure-button"
          ..style=buttonStyle)("Edit"),
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

}