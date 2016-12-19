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
  int sortState;
}

@Component()
class AppComponent extends UiStatefulComponent<AppProps, AppState>{
  @override
  Map getInitialState() => (newState()..todos= [
  (new Task(1,title:"Eat Breakfast",isCompleted:true)),
  (new Task(0,title:"Eat Lunch",isCompleted:true)),
  (new Task(2,title:"Eat Dinner",isCompleted:false))
  ]
  ..sortState = 0);

  void createTask(Task newTask){
    this.state.todos.add(newTask);
    this.sortTodos(this.state.sortState);
    this.setState(this.state);
  }

  void deleteTask(String taskTitle){
    int task = this.findTask(taskTitle);
    if(task > -1){
      this.state.todos.removeAt(task);
      this.sortTodos(this.state.sortState);
      this.setState(this.state);
    }
  }

  void toggleTaskCompletion(String taskTitle){
    int task = this.findTask(taskTitle);
    if(task > -1){
      this.state.todos[task].setIsCompleted(!this.state.todos[task].isCompleted);
      this.setState(this.state);
    }

  }

  int findTask(String taskTitle){
    int task = -1;
    for(int i=0; i<this.state.todos.length; i++){
      if(this.state.todos[i].title == taskTitle){
        task = i;
      }
    }
    return task;
  }

  void sortTodos(int sortState){
    if(sortState == 1){
      this.state.todos.sort(this.taskTimeCompare);
    }else{
      this.state.todos.sort(this.taskAlphaCompare);
    }
  }

  int taskAlphaCompare(Task t1, Task t2){
    return t1.title.toLowerCase().compareTo(t2.title.toLowerCase());
  }

  int taskTimeCompare(Task t1, Task t2){
    if(t1.timeStamp < t2.timeStamp){
      return -1;
    }else if(t1.timeStamp > t2.timeStamp){
      return 1;
    }else{
      return 0;
    }
  }

  dynamic handleAlphaSort(react.SyntheticMouseEvent e){
    this.state.sortState = 0;
    this.sortTodos(0);
    this.setState(this.state);
  }

  dynamic handleTimeSort(react.SyntheticMouseEvent e){
    this.state.sortState = 1;
    this.sortTodos(1);
    this.setState(this.state);
  }

  void saveTask(String taskTitle, Task updatedTask){
    int task = this.findTask(taskTitle);
    if(task > -1){
      this.state.todos[task] = updatedTask;
      this.sortTodos(this.state.sortState);
      this.setState(this.state);
    }
  }

  @override
  render(){

    //TODO:: Breakdown and make TodoList Sort Component!
    Map sortButtonStyle = new Map();
    sortButtonStyle["margin"] = "10px";

    return (Dom.div())(
        Dom.h1()("React Todo App"),
        (CreateTodo()
          ..todos = this.state.todos
          ..createTaskFunc = this.createTask)(),
        (Dom.button()
          ..onClick=this.handleAlphaSort
          ..style=sortButtonStyle
          ..className="pure-button")("Alpha-Sort"),
        (Dom.button()
          ..onClick=this.handleTimeSort
          ..style=sortButtonStyle
          ..className="pure-button")("Time-Sort"),
        (TodoList()
          ..todos=this.state.todos
          ..deleteTask=this.deleteTask
          ..toggleTaskCompletion=this.toggleTaskCompletion
          ..saveTask=this.saveTask)()

    );
  }
}