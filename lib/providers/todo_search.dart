import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// There are two reasons for doing this:
/// First, being consistent in handling all states, makes code predictable
/// when looking at code later or collaborating as a team.
/// Second, avoid type clashes.
/// As you may already know, the provider finds objects in the widget tree based on the type
/// but if the type is the same, it cannot access the objects further away from it.//
class TodoSearchState extends Equatable {
  final String searchTerm;
  const TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() {
    return const TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class TodoSearch with ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();
  TodoSearchState get state => _state;

  void setSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}
