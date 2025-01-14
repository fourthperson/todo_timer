part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoListStarted extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Item todo;

  const AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final Item todo;

  const RemoveTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class ToggleTodoEvent extends TodoEvent {
  final Item todo;

  const ToggleTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}
