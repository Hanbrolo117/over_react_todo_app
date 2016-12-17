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
    return (Dom.td()..style=taskStyle)(this.props.task.title);
    //---------------------------------------------------------------
  }


  ReactElement renderActionSection(){
    if(this.state.isEditing){
      return Dom.td()(
          Dom.button()("Save"),
          Dom.button()("Cancel")
      );
    }

    return Dom.td()(
        Dom.button()("Edit"),
        Dom.button()("Delete")
    );

  }

  @override
  render(){
    return Dom.tr()(
        this.renderTaskSection(),
        this.renderActionSection()
    );
  }
}