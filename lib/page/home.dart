import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_timer/bloc/todo_bloc.dart';
import 'package:todo_timer/model/item.dart';
import 'package:todo_timer/widget/item_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UniqueKey textInputKey = UniqueKey();
  final UniqueKey countKey = UniqueKey();
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            if (state is TodoListLoadedState) {
              int numItemsLeft = state.items.length -
                  state.items.where((e) => e.completed).length;

              List<Item> items = state.items;

              return ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                children: [
                  TextField(
                    key: textInputKey,
                    controller: textController,
                    decoration: InputDecoration(
                      labelText: 'What needs to be done?',
                    ),
                    onSubmitted: (String value) {
                      if (value.isEmpty) return;
                      Item newItem = Item(description: value);
                      BlocProvider.of<TodoBloc>(context).add(
                        AddTodoEvent(newItem),
                      );
                      textController.clear();
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      key: countKey,
                      '$numItemsLeft items left',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ItemCard(item: items[index]);
                    },
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'Error loading items',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
