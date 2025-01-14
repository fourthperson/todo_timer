import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_timer/bloc/todo_bloc.dart';
import 'package:todo_timer/page/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoBloc()..add(TodoListStarted()),
        child: Home(),
      ),
    );
  }
}
