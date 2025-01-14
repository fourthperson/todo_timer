import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class ItemTimer {
  final DateTime start;
  DateTime? end;

  ItemTimer(this.end, {required this.start});
}

class Item {
  final String id = uuid.v4();
  final String description;
  final bool completed;

  final List<ItemTimer> _timerList = [];

  Item({
    required this.description,
    this.completed = false,
  });

  Item copyWith({
    String? description,
    bool? completed,
  }) {
    return Item(
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }

  void startTimer() {
    if (_timerList.isEmpty) {
      _timerList.add(ItemTimer(null, start: DateTime.now()));
    } else {
      ItemTimer lastTimer = _timerList.last;
      if (lastTimer.end != null) {
        // last timer ended, create a new one
        _timerList.add(ItemTimer(null, start: DateTime.now()));
      }
    }
  }

  void stopTimer() {
    if (_timerList.isEmpty) return;
    ItemTimer lastTimer = _timerList.last;
    if (lastTimer.end == null) {
      lastTimer.end = DateTime.now();
      _timerList[_timerList.length - 1] = lastTimer;
    }
  }

  Duration getTotalDuration() {
    if (_timerList.isEmpty) return Duration.zero;
    Duration totalDuration = const Duration();
    for (ItemTimer timer in _timerList) {
      if (timer.end != null) {
        totalDuration += timer.end!.difference(timer.start);
      }
    }
    return totalDuration;
  }
}
