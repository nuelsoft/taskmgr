class Task {
  String category;
  String course;
  String details;
  int date;
  int hour;
  int minute;
  int duration;
  String dayGroup;

  Task.fromJSON(Map<String, dynamic> json)
      : category = json['category'],
        course = json['course'],
        details = json['details'],
        date = json['date'],
        hour = json['hour'],
        minute = json['minute'],
        duration = json['duration'],
        dayGroup = json['dayGroup'];

  static fromList(List<Map<String, dynamic>> ls) =>
      ls.map((e) => Task.fromJSON(e));

  Map<String, dynamic> get json {
    return {
      "category": category,
      "course": course,
      "details": details,
      "hour": hour,
      "date": date,
      "minute": minute,
      "duration": duration,
      "dayGroup": dayGroup
    };
  }

  int get aggregateTime {
    return int.tryParse('${startTime.replaceAll(":", "")}');
  }

  String get startTime {
    return '${hour < 9 ? '0' : ''}$hour:${minute < 9 ? '0' : ''}$minute';
  }

  String get endTime {
    DateTime dt = date == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(date);
    DateTime end = DateTime(dt.year, dt.month, dt.day, hour, minute)
        .add(Duration(minutes: duration));

    return '${end.hour < 9 ? '0' : ''}${end.hour}:${end.minute < 9 ? '0' : ''}${end.minute}';
  }

  Task();
}
