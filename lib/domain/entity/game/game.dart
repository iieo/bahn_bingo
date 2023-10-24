class Game {
  final String id;
  int fieldSize;
  List<EventItem> events;
  Game({required this.id})
      : events = [
          EventItem(task: '1'),
          EventItem(task: '2', done: true),
          EventItem(task: '3'),
          EventItem(task: '4'),
          EventItem(task: '5'),
          EventItem(task: '6'),
          EventItem(task: '7'),
          EventItem(task: '8'),
          EventItem(task: '9')
        ],
        fieldSize = 3;
}

class EventItem {
  final String task;
  bool done;
  EventItem({required this.task, this.done = false});

  void toggleDone() {
    done = !done;
  }

  EventItem.empty()
      : task = '',
        done = false;
}
