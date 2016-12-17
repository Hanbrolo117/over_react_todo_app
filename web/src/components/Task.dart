import 'dart:collection';

class Task{
  String _title;
  bool _isCompleted;

  Task({String title:"No Title Specified", bool isCompleted:false}){
    this._title = title;
    this._isCompleted = isCompleted;
  }

  String get title => this._title;
  bool get isCompleted => this._isCompleted;

  void setTitle(String newTitle){this._title = newTitle;}
  void set isCompleted(bool isCompleted){this._isCompleted = isCompleted;}

}
