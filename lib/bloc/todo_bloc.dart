import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_timer/model/item.dart';

part 'todo_state.dart';

part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<TodoListStarted>(_onStart);
    on<AddTodoEvent>(_addTodo);
    on<RemoveTodoEvent>(_removeTodo);
    on<ToggleTodoEvent>(_toggleTodo);
  }

  void _onStart(TodoListStarted event, Emitter<TodoState> emit) {
    emit(const TodoListLoadedState(items: []));
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is! TodoListLoadedState) return;
    emit(TodoListLoadedState(items: [...state.items, event.todo]));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;

    if (state is! TodoListLoadedState) return;

    List<Item> items = state.items;
    items.removeWhere((i) => i.id == event.todo.id);

    emit(TodoListLoadedState(items: items));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;

    if (state is! TodoListLoadedState) return;

    List<Item> items = List.from(state.items);
    int index = items.indexWhere((e) => e.id == event.todo.id);
    if (index == -1) return;

    Item target = items[index];
    Item updated = target.copyWith(completed: !target.completed);
    items[index] = updated;

    emit(TodoListLoadedState(items: [...items]));
  }
}
