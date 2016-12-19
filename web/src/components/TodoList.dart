import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';
import 'TodoListHeader.dart';
import 'TodoListItem.dart';

///Use 'TodoList' component to render a table
///with its rows as a list of [TodoListItem] components.
///
/// * Related to [TodoListItem]
/// * Related to [TodoListHeader]
/// * Related to [TodoListItem]
@Factory()
UiFactory<TodoListProps> TodoList;

@Props()
class TodoListProps extends UiProps{
  ///The list of [Task]s to render as [TodoListItem]s
  ///inside of this component.
  ///
  /// Initial: new List<Task>()
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
class TodoListState extends UiState{

}

@Component()
class TodoListComponent extends UiStatefulComponent<TodoListProps, TodoListState>{


  @override
  Map getInitialProps() => (
      newProps()
        ..todos = new List<Task>()
        ..toggleTaskCompletion = null
        ..saveTask = null);

  @override
  Map getInitialState() => (newState());

  @override
  render(){
    return (Dom.table()..className="pure-table")(
        TodoListHeader()(),
        Dom.tbody()(
          this.renderTasks()
        )
    );
  }

  ///This creates a List of TodoListItem ReactElements
  ///that will be rendered in this component, using [Task]
  ///data from [this.props.todos].
  List renderTasks(){
    List tasks = [];
    if(this.props.todos.isNotEmpty){
      for(var task in this.props.todos) {
        var item = (TodoListItem()
          ..task =task
          ..todos = this.props.todos
          ..key=task.title
          ..deleteTask=this.props.deleteTask
          ..toggleTaskCompletion=this.props.toggleTaskCompletion
          ..saveTask=this.props.saveTask
        )();
        tasks.add(item);
      }
      return tasks;
    }

    return null;
  }

}