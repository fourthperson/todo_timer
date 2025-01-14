import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_timer/bloc/todo_bloc.dart';
import 'package:todo_timer/model/item.dart';
import 'package:todo_timer/util/stopwatch.dart';

class ItemCard extends StatefulWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late StopwatchEx _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    _stopwatch = StopwatchEx(initialOffset: widget.item.getTotalDuration());

    _timer = Timer.periodic(
      Duration(milliseconds: 250),
      (Timer timer) {
        if (!_stopwatch.isRunning) return;
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void _handleButtonClick() {
    // if timer is running, stop stopwatch and timer
    if (_stopwatch.isRunning) {
      widget.item.stopTimer();
      _stopwatch.stop();
      // re-render
      setState(() {});
    }
    // timer not running, start timer and stopwatch
    else {
      widget.item.startTimer();
      _stopwatch.start();
      // re-render
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 6,
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        child: ListTile(
          onTap: () {
            context.read<TodoBloc>().add(ToggleTodoEvent(widget.item));
          },
          leading: Icon(
            widget.item.completed
                ? Icons.task_alt
                : Icons.radio_button_unchecked,
            color: Colors.blue,
            size: 18.0,
          ),
          title: Text(widget.item.description),
          trailing: Wrap(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _handleButtonClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _stopwatch.isRunning ? Colors.red : Colors.green,
                      elevation: 0,
                    ),
                    child: Text(
                      _stopwatch.isRunning ? 'Stop' : 'Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    _formatTime(_stopwatch.elapsedMilliseconds),
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
