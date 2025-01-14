part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitialState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoListLoadedState extends TodoState {
  final List<Item> items;

  const TodoListLoadedState({this.items = const []});

  @override
  List<Object> get props => [items];
}

class TodoErrorState extends TodoState {
  @override
  List<Object?> get props => [];
}
