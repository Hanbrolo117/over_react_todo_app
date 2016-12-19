import 'dart:html';
import 'dart:collection';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import 'Task.dart';

///Use 'TodoListHeader' component to render the
///header row of a table for a [TodoList] component
///
/// * Related to [TodoList]
@Factory()
UiFactory<TodoListHeaderProps> TodoListHeader;

@Props()
class TodoListHeaderProps extends UiProps{

}

@State()
class TodoListHeaderState extends UiState{

}

@Component()
class TodoListHeaderComponent extends UiStatefulComponent<TodoListHeaderProps, TodoListHeaderState>{

  @override
  Map getInitialProps() => (newProps());

  @override
  Map getInitialState() => (newState());


  @override
  render(){
      return Dom.thead()(
          Dom.tr()(
              Dom.th()("Task"),
              Dom.th()("Actions")
          )
      );
  }

}