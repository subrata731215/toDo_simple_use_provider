import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/todo_model.dart';

class ToDoProvider extends ChangeNotifier {
  final List<ToDoModel> toDoList = [];



  void addToDoList(ToDoModel toDoModel) {
    toDoList.add(toDoModel);
    notifyListeners();
  }

  void removeToDoList(ToDoModel toDoModel) {
    final index = toDoList.indexOf(toDoModel);
    toDoList.removeAt(index);
    notifyListeners();
  }

  void toDoStatusChanges(ToDoModel toDoModel) {
    final index = toDoList.indexOf(toDoModel);
    toDoList[index].toggleCompleted();
    notifyListeners();
  }
}
