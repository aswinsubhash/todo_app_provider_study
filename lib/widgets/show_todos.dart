import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/providers/providers.dart';
import 'package:todo_app_provider/widgets/show_background.dart';
import 'package:todo_app_provider/widgets/todo_item.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodos>().state.filteredTodos;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          key: ValueKey(todos[index].id),
          child: TodoItem(todo: todos[index]),
          onDismissed: (_) {
            context.read<TodoList>().removeTodo(todos[index]);
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you really want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context,
                          false), // By giving false, confirmDismiss callback returns false.
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context,
                          true), // By giving true, confirmDismiss callback returns true.
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
