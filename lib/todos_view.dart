import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/local_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/todo_item.dart';

class TodosView extends StatelessWidget {
  TodosView({super.key});

  final LocalStorage storage = LocalStorage();

  Future<List<Todo>> getTodos() async {
    LocalStorage storage = LocalStorage();
    String a = await storage.getData('todoList');
    // storage.deleteData('todoList');
    if (a.isEmpty) {
      List<Todo> list = [];
      return list;
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
      return todoList.todoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
            height: 400,
            width: double.infinity,
            child: FutureBuilder(
                future: getTodos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TodoItem(todo: snapshot.data![index]);
                        });
                  }
                  return const Text('...');
                })),
        ElevatedButton(
            onPressed: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const MyHomePage();
                  }))
                },
            child: const Text('Home'))
      ]),
    );
  }
}
