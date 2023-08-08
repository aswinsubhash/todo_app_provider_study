import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_provider/models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(id: '1', desc: 'Clean the room'),
      Todo(id: '2', desc: 'Wash the dish'),
      Todo(id: '3', desc: 'Do homework'),
    ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;

  /// Create a new todo item whose desc is todoDesc, stores it in the newTodo variable,
  /// and uses the spread operator of the list to create a new todo list that combines the existing todos
  /// and newTodo and stores it in newTodos.
  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  /// While scanning _state.todos using the map function,
  /// if the id of the todo currently being scanned is the same as the id passed as an argument to editTodo,
  /// the new Todo where the id is id, desc is todoDesc, and completed is the completed of the todo being scanned is returned.
  /// Otherwise the original todo is returned.
  /// Store the new todo list created by the map function in the newTodos variable.
  void editTodo(String id, String todoDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }


  /// While scanning _state.todo using the map function,
  /// if the id of the todo currently being scanned is the same as the id passed as an argument to toggleTodo,
  /// the new todo where the id is the id, desc is the desc of the todo being scanned
  /// and completed is the reversed completed of the todo being scanned is returned.
  /// Otherwise existiing todo is returned.
  /// Store the new todo list created by the map function in the newTodos
  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }


  /// While scanning _state.todo using where funtion,
  /// a new todo list is created only with todos whose id of todo being scanned is not the same 
  /// as that of todo passed as an argument to removeTodo,
  /// and stored in the newTodos varaible.
  void removeTodo(Todo todo){
    final newTodos = _state.todos.where((Todo t) => t.id != todo.id).toList();

    _state = _state.copyWith(todos: newTodos);
    log(_state.toString());
    notifyListeners();
  }
}
