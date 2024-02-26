import 'dart:convert';

import 'package:todo_app/local_storage.dart';

class Todo {
  Todo(
      {required this.taskName,
      required this.taskDescription,
      required this.isComplete});

  String taskName;
  String taskDescription;
  bool isComplete;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isComplete: json['isComplete']);

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isComplete': isComplete
    };
  }

  Future<String> pushToList() async {
    LocalStorage storage = LocalStorage();
    String a = await storage.getData('todoList');
    // storage.deleteData('todoList');
    if (a.isEmpty) {
      List<Todo> list = [];
      TodoList todoList = TodoList(todoList: list);
      todoList.addTodo(this);
      print(this.toJson());
      return jsonEncode(todoList.todoList);
    } else {
      String jsonList = await storage.getData('todoList');
      List list = jsonDecode(jsonList);
      print('$list 1');
      List<Todo> list2 = [];
      for (var e in list) {
        list2.add(Todo.fromJson(e));
      }
      print('$list2 2');
      TodoList todoList = TodoList(todoList: list2);
      todoList.addTodo(this);
      print('s ${await storage.getData('todoList')}');
      return jsonEncode(todoList.todoList);
    }
  }
}

class TodoList {
  TodoList({required this.todoList});

  List<Todo> todoList;

  addTodo(Todo todo) {
    todoList.add(todo);
  }

  factory TodoList.fromJson(Map<String, dynamic> json) =>
      TodoList(todoList: json['todoList']);

  Map<String, dynamic> toJson() {
    return {
      'todoList': todoList,
    };
  }
}
