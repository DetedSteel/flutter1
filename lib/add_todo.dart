import 'package:flutter/material.dart';
import 'package:todo_app/local_storage.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/todos_view.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => AddTodoState();
}

class AddTodoState extends State<AddTodo> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String todoTitle = '';
  String todoDescription = '';
  bool isComplete = false;

  void addTodo() async {
    print(await LocalStorage().getData('todoList'));
    Todo todo = Todo(
        taskName: todoTitle,
        taskDescription: todoDescription,
        isComplete: isComplete);
    String jsonList = await todo.pushToList();
    print(jsonList);
    LocalStorage().writeData(jsonList, 'todoList');
    print(await LocalStorage().getData('todoList'));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodosView();
    }));
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _titleController,
                onSubmitted: (String value) {
                  print(value);
                },
                onChanged: (String value) {
                  todoTitle = value;
                  print(todoTitle);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Todo title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _descriptionController,
                onSubmitted: (String value) {
                  print(value);
                },
                onChanged: (String value) {
                  todoDescription = value;
                  print(todoDescription);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Todo description',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTodo();
                },
                child: const Text('Add todo'))
          ],
        )));
  }
}
