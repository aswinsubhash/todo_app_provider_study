import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_provider/models/todo_model.dart';
import 'package:todo_app_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  const ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount with ChangeNotifier {
  ActiveTodoCountState _state = ActiveTodoCountState.initial();
  ActiveTodoCountState get state => _state;

  /// This update function is called multiple times.
  /// The first time we get a dependent value, and every time that dependent value changes.
  /// Therefore, the initial value of 0 becomes update immediately.
  /// Again, the update function receives the instance of the TodoList ChangeNotifier as an argument
  /// and is called whenever there is a change in the TodoList.
  /// Each time the update function is called it counts the number of items for which completed is false.
  /// While scanning the state.dot todos of the todoList received as an argument using the where function,
  /// the length fo the ones whose completed value of the todo being scanned is false, that is,
  /// the active ones, is stored in the newActiveTodoCount variable.
  void update(TodoList todoList) {
    log(todoList.state.toString());
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;

    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    log(state.toString());
    notifyListeners();
  }
}
