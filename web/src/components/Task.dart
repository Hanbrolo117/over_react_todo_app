import 'dart:collection';

class Task{
  String _title;
  bool _isCompleted;
  int _timeStamp;

  Task(int timeStamp,{String title:"No Title Specified", bool isCompleted:false}){
    this._timeStamp = timeStamp;
    this._title = title;
    this._isCompleted = isCompleted;
  }

  String get title => this._title;
  bool get isCompleted => this._isCompleted;
  int get timeStamp => this._timeStamp;


  void setTitle(String newTitle){this._title = newTitle;}
  void setIsCompleted(bool isCompleted){this._isCompleted = isCompleted;}
  void setTimeStamp(int newTimeStamp){this._timeStamp = newTimeStamp;}
}
