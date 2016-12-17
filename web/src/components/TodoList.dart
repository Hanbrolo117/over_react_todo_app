import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';
import 'TodoListHeader.dart';
import 'TodoListItem.dart';


@Factory()
UiFactory<TodoListProps> TodoList;

@Props()
class TodoListProps extends UiProps{
  List<Task> todos;
}

@State()
class TodoListState extends UiState{

}

@Component()
class TodoListComponent extends UiStatefulComponent<TodoListProps, TodoListState>{


  @override
  Map getInitialProps() => (newProps());

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

  List renderTasks(){
    List tasks = [];
    if(this.props.todos.isNotEmpty){
      for(var task in this.props.todos) {
        var item = (TodoListItem()
          ..task =task
          ..key=task.title)();
        tasks.add(item);
      }
      return tasks;
    }

    return null;
  }

}