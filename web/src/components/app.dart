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


///Use 'App' component to render a Todo List Application.
///
/// * Related to [TodoList]
/// * Related to [CreateTodo]
@Factory()
UiFactory<AppProps> App;

@Props()
class AppProps extends UiProps{

}

@State()
class AppState extends UiState{
  ///This state field manages the state the list of tasks defined by the user.
  ///
  /// Initial: List of 3 Task objects, for preview only, would just be new List<Task>
  List<Task> todos;

  ///This state field manages the sort function to use on the task list [todos].
  ///For now there are two sort functions, an alphabetical one, and a timestamp order one.
  ///
  /// Initial: 0
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


  ///This inserts a newly created [Task] object
  ///[newTask] into the app's "Task List" [this.state.todos].
  void createTask(Task newTask){
    if(newTask != null) {
      this.state.todos.add(newTask);
      this.sortTodos(this.state.sortState);
      this.setState(this.state);
    }
  }

  ///This function deletes a [Task] object from [this.state.todos]
  ///using [taskTitle] to find the [Task] object's position in the
  ///list for deletion.
  void deleteTask(String taskTitle){
    int task = this.findTask(taskTitle);
    if(task > -1){
      this.state.todos.removeAt(task);
      this.sortTodos(this.state.sortState);
      this.setState(this.state);
    }
  }

  ///Toggles a [Task] object's [Task.isCompleted] value by
  ///Negating it's current boolean value.
  void toggleTaskCompletion(String taskTitle){
    int task = this.findTask(taskTitle);
    if(task > -1){
      this.state.todos[task].setIsCompleted(!this.state.todos[task].isCompleted);
      this.setState(this.state);
    }
  }

  ///Finds a [Task] object in the [this.state.todos] task list using a [Task]
  ///object's [Task.title] field. If it is found, it's list index position is
  ///returned, otherwise, the function returns a -1.
  int findTask(String taskTitle){
    if(taskTitle == null){return -1;}

    int task = -1;
    for(int i=0; i<this.state.todos.length; i++){
      if(this.state.todos[i].title == taskTitle){
        task = i;
      }
    }
    return task;
  }

  ///This function, depending on the value of [this.state.sortState]
  ///will sort the current state of [this.state.todos] in either
  ///Alphabetical order, or in timeStamp order.
  void sortTodos(int sortState){
    if(sortState == 1){
      this.state.todos.sort(this.taskTimeCompare);
    }else{
      this.state.todos.sort(this.taskAlphaCompare);
    }
  }

  ///This is the Alphabetical Comparision function that is used for the
  ///Alphabetical sorting of [this.state.todos].
  int taskAlphaCompare(Task t1, Task t2){
    return t1.title.toLowerCase().compareTo(t2.title.toLowerCase());
  }

  ///This is the TimeStamp Comparision function that is used for the
  ///TimeStamp sorting of [this.state.todos].
  int taskTimeCompare(Task t1, Task t2){
    if(t1.timeStamp < t2.timeStamp){
      return -1;
    }else if(t1.timeStamp > t2.timeStamp){
      return 1;
    }else{
      return 0;
    }
  }

  ///This is an Event handler for sorting [this.state.todos] in
  ///Alphabetical order.
  dynamic handleAlphaSort(react.SyntheticMouseEvent e){
    this.state.sortState = 0;
    this.sortTodos(0);
    this.setState(this.state);
  }

  ///THis is an Event handler for sorting [this.state.todos] in
  ///TimeStamp order.
  dynamic handleTimeSort(react.SyntheticMouseEvent e){
    this.state.sortState = 1;
    this.sortTodos(1);
    this.setState(this.state);
  }

  ///This function is used to "save" or insert an updated
  ///[Task] object [updatedTask] into it's current index position in
  ///[this.state.todos], using [taskTitle] to find it's index
  ///position.
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
          ..createTaskFunc = this.createTask
        )(),
        (Dom.button()
          ..onClick=this.handleAlphaSort
          ..style=sortButtonStyle
          ..className="pure-button"
        )("Alpha-Sort"),
        (Dom.button()
          ..onClick=this.handleTimeSort
          ..style=sortButtonStyle
          ..className="pure-button"
        )("Time-Sort"),
        (TodoList()
          ..todos=this.state.todos
          ..deleteTask=this.deleteTask
          ..toggleTaskCompletion=this.toggleTaskCompletion
          ..saveTask=this.saveTask
        )()
    );
  }
}