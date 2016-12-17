import 'dart:html';
import 'dart:core';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;
import 'package:over_react/over_react.dart';
import 'components/app.dart';



void main(){
  //Initialize React within our Dart App:
  react_client.setClientConfiguration();
  var form = [Dom.p()("Hey"),Dom.p()("there"),Dom.p()("world!")];
  react_dom.render((App()..className="TodoApp")(),querySelector('#react_mount_point'));
}