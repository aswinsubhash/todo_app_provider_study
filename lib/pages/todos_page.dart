import 'package:flutter/material.dart';
import 'package:todo_app_provider/widgets/create_todo.dart';
import 'package:todo_app_provider/widgets/search_and_filter_todo.dart';
import 'package:todo_app_provider/widgets/show_todos.dart';
import 'package:todo_app_provider/widgets/todo_header.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Column(
              children: [
                const TodoHeader(),
                const CreateTodo(),
                const SizedBox(height: 20.0),
                SearchAndFilterTodo(),
                const ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
