import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_app_provider/models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  const TodoFilterState({
    required this.filter,
  });

  /// This means that we do not filter in the first place.
  /// If you create a factory constructor like this we can quickly find out 
  ///  what the initial state is even after a long time after developement.
  factory TodoFilterState.initial() {
    return const TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class TodoFilter  with ChangeNotifier{
  TodoFilterState _state = TodoFilterState.initial();

  /// Created a getter so that it can be accessed from outside.
  /// It is a king of safe guard for the state.
  TodoFilterState get state => _state;

  /// This changeFilter function is triggered whenever the All, Active or  completed tabs are clicked.
  /// And the point to note here is that we use the copyWith function ot create a new state.
  /// The copyWith function creates a new value without mutation.
  /// Also, the copyWith funcion can be particularly useful when a class has multiple propertise.
  /// This is only because the changed values need to be passed as an arguement.
  void changeFilter(Filter newFilter){
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }

}


