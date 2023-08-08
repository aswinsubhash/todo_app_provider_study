import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_app_provider/models/todo_model.dart';
import 'package:todo_app_provider/providers/todo_filter.dart';
import 'package:todo_app_provider/providers/todo_list.dart';
import 'package:todo_app_provider/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  const FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos with ChangeNotifier {
  FilteredTodosState _state = FilteredTodosState.initial();
  FilteredTodosState get state => _state;

  /// About todo list filter
  /// First using switch statement, calculate the todo list to show based on the filter value of the todoFilter.state.
  /// If filter is active, it filters todo list for which completed is false.
  /// While scanning the state.todos of todoList recieved as an argument using the where function, todo items for which
  /// completed is false are filtered and stored in _filteredTodos.
  /// About todo search filter
  /// If the state.searchTerm of todoSearch is not emplty, the user entered a search term,
  /// so only todo lists containing the search term are filtered.
  /// While scanning the already filtered _filterTodos using the where function, todo items
  /// for which desc contains todoSearch.state.searchTerm are filtered and stored in _filteredTodos again.

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
          .toList();
    }

    _state = _state.copyWith(filteredTodos: filteredTodos);
    notifyListeners();
  }
}
