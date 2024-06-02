class AvailableTimes {
  dynamic sunday;
  dynamic monday;
  dynamic tuesday;
  dynamic wednesday;
  dynamic thursday;
  dynamic friday;
  dynamic saturday; // Can be a String ("none") or a List<TimeSlot>

  AvailableTimes({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  // Return text for a given day's available times
  String dayText(dynamic day) {
    if (day is String) {
      return 'None';
    } else {
      List<TimeSlot> timeSlots = day;
      return timeSlots.map((slot) => '${slot.start} - ${slot.end}').join(', ');
    }
  }

  // Create an instance of AvailableTimes from JSON
  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    return AvailableTimes(
      sunday: _parseDay(json['sunday']),
      monday: _parseDay(json['monday']),
      tuesday: _parseDay(json['tuesday']),
      wednesday: _parseDay(json['wednesday']),
      thursday: _parseDay(json['thursday']),
      friday: _parseDay(json['friday']),
      saturday: _parseDay(json['saturday']),
    );
  }

  // Parse a day's times (either "none" or a list of TimeSlots)
  static dynamic _parseDay(dynamic day) {
    if (day is String) {
      return day;
    } else {
      return (day as List).map((e) => TimeSlot.fromJson(e)).toList();
    }
  }

  // Convert the AvailableTimes instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'sunday': _dayToMap(sunday),
      'monday': _dayToMap(monday),
      'tuesday': _dayToMap(tuesday),
      'wednesday': _dayToMap(wednesday),
      'thursday': _dayToMap(thursday),
      'friday': _dayToMap(friday),
      'saturday': _dayToMap(saturday),
    };
  }

  // Convert a day's times to a map
  static dynamic _dayToMap(dynamic day) {
    if (day is String) {
      return day;
    } else {
      return (day as List<TimeSlot>).map((e) => e.toMap()).toList();
    }
  }
}

class TimeSlot {
  String start;
  String end;

  TimeSlot({required this.start, required this.end});

  TimeSlot copyWith({
    String? start,
    String? end,
  }) =>
      TimeSlot(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  // Create an instance of TimeSlot from JSON
  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      start: json['start'],
      end: json['end'],
    );
  }

  // Convert the TimeSlot instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }
}
