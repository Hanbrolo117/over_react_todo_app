import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';


///Use 'TodoListItem' component to render a
///table row that display's a [Task] object's
///[Task] object's title field along with various actions.
@Factory()
UiFactory<TodoListItemProps> TodoListItem;

@Props()
class TodoListItemProps extends UiProps{
  ///This Prop is the [Task] object that is to be
  ///used for getting the data that will be rendered
  ///in this component, specifically the [Task.title]
  ///data field.
  ///
  /// Initial: null
  Task task;

  ///This Prop is used to store the list of [Task]s that
  ///the [task] data field exists in. Helps with input validation
  ///checks when this component is being edited by a user.
  ///
  /// Initial: new List<Task>
  List<Task> todos;

  ///A function that is used to delete a [Task] object
  ///from a list of [Task]s.
  ///
  /// Initial: null
  var deleteTask;


  ///A function that toggles a [Task]'s [Task.isCompleted] field
  ///to represent the Task as a completed task (true) or a
  ///non-completed task (false).
  ///
  /// Initial: null
  var toggleTaskCompletion;

  ///A function that inserts a [Task] object into the list of [Task]s
  ///that this component is given to render as [TodoListItem]s.
  ///
  /// Initial: null
  var saveTask;
}

@State()
class TodoListItemState extends UiState{
  ///A State field that manages whether the component is in editing mode or not.
  ///
  /// Initial: false
  bool isEditing;

  ///A State field that acts as the 'single source of truth' value for keeping track
  ///of the user input of the input domprop value when [isEditing] is true.
  ///
  /// Initial: ""
  String editValue;
}

@Component()
class TodoListItemComponent extends UiStatefulComponent<TodoListItemProps,TodoListItemState>{

  @override
  Map getDefaultProps() => (newProps()..task = null);

  @override
  Map getInitialState() =>(newState()..isEditing = false);


  ///This function returns a ReactElement that displays either
  ///a [Task] object's [Task] object's title or a form input with it's defaultvalue
  ///equal to the [Task]'s title field depending on whether [this.state.isEditing] is true
  ///or false, respectively.
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
                ..ref="editInput"
              )()
          )
      );
    }
    return (Dom.td()
      ..style=taskStyle
      ..onClick=this.handleTaskCompletion
      )(this.props.task.title);
    //---------------------------------------------------------------
  }


  ///This function returns a ReactElement that displays buttons that allow for
  ///certain actions a user can take depending on the value of this state's [isEditing]
  ///field.
  ReactElement renderActionSection(){

    var buttonStyle = new Map();
    buttonStyle["margin"] = "5px";
    if(this.state.isEditing){
      return Dom.td()(
          (Dom.button()
            ..className="pure-button pure-button-primary"
            ..style=buttonStyle
            ..onClick=this.handleSave
          )("Save"),
          (Dom.button()
            ..className="pure-button"
            ..style=buttonStyle
            ..onClick=this.toggleEdit
          )("Cancel")
      );
    }

    return Dom.td()(
        (Dom.button()
          ..className="pure-button"
          ..style=buttonStyle
          ..onClick=this.toggleEdit
        )("Edit"),
        (Dom.button()
          ..className="button-warning pure-button"
          ..style=buttonStyle
          ..onClick=this.handleDelete
        )("Delete")
    );

  }

  @override
  render(){
    return Dom.tr()(
        this.renderTaskSection(),
        this.renderActionSection()
    );
  }

  ///An Event Handler that toggle's the [Task] object's completion field value.
  dynamic handleTaskCompletion(react.SyntheticMouseEvent e){
    this.props.toggleTaskCompletion(this.props.task.title);
    return true;
  }


  ///An Event handler that delete's this component's [Task] object from
  ///the App's task list.
  dynamic handleDelete(react.SyntheticMouseEvent e){
    this.props.deleteTask(this.props.task.title);
    return true;
  }


  ///An Event Handler that toggle's the boolean value of this component's
  ///[isEditiong] field value and set's it's state.
  dynamic toggleEdit(react.SyntheticMouseEvent e){
    this.state.isEditing = !this.state.isEditing;
    this.setState(this.state);
  }


  ///This Event Handler updates this component's copy of the inputElement's
  ///value which allows this application to follow the React standard of having
  ///a "single source of truth"
  dynamic handleOnEditChange(react.SyntheticFormEvent e){
    InputElement inputVal = this.ref("editInput");
    if(inputVal == null){return true;}

    this.state.editValue = inputVal.value;
    this.setState(this.state);
  }

  ///An Event Handler that updates the value of this component's [Task]
  ///object using the given savefunction [saveTask].
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