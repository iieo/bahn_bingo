class Game {
  final String id;
  int fieldSize;
  List<EventItem> events;
  Game({required this.id, this.fieldSize = 3, this.events = const []});

  factory Game.fromJson(String id, Map<String, dynamic> json) {
    List<EventItem> events = [];
    for (var event in json['events']) {
      events.add(EventItem(task: event['task'], done: event['done']));
    }
    return Game(id: id, fieldSize: json['fieldSize'], events: events);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> eventsJson = [];
    for (var event in events) {
      eventsJson.add({'task': event.task, 'done': event.done});
    }
    return {'id': id, 'fieldSize': fieldSize, 'events': eventsJson};
  }
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
