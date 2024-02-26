import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Task name: ${todo.taskName} Description: ${todo.taskDescription}',
                  style: const TextStyle(
                      fontSize: 20, backgroundColor: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
