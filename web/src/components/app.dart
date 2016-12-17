import 'dart:html';
import 'dart:collection';

import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

//Custom Components:
import 'TodoList.dart';
import 'CreateTodo.dart';
import 'Task.dart';

@Factory()
UiFactory<AppProps> App;

@Props()
class AppProps extends UiProps{

}

@State()
class AppState extends UiState{
  List<Task> todos;
}

@Component()
class AppComponent extends UiStatefulComponent<AppProps, AppState>{
  @override
  Map getInitialState() => (newState()..todos= [
  (new Task(title:"Eat Breakfast",isCompleted:true)),
  (new Task(title:"Eat Lunch",isCompleted:true)),
  (new Task(title:"Eat Dinner",isCompleted:false))
  ]);

  void createTask(){}


  @override
  render(){
    print(this.state.todos[0].title);
    return (Dom.div())(
        Dom.h1()("React Todo App"),
        (CreateTodo()
          ..todos = this.state.todos
          ..createTaskFunc = this.createTask)(),
        (TodoList()..todos=this.state.todos)()

    );
  }
}