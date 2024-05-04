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

  String dayText(dynamic day) {
    if (day is String) {
      return 'None';
    } else {
      List<TimeSlot> timeSlots = day;
      return timeSlots.map((slot) => '${slot.start} - ${slot.end}').join(', ');
    }
  }

  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    return AvailableTimes(
      sunday: json['sunday'] is String
          ? json['sunday']
          : (json['sunday'] as List).map((e) => TimeSlot.fromJson(e)).toList(),
      monday: json['monday'] is String
          ? json['monday']
          : (json['monday'] as List).map((e) => TimeSlot.fromJson(e)).toList(),
      tuesday: json['tuesday'] is String
          ? json['tuesday']
          : (json['tuesday'] as List).map((e) => TimeSlot.fromJson(e)).toList(),
      wednesday: json['wednesday'] is String
          ? json['wednesday']
          : (json['wednesday'] as List)
              .map((e) => TimeSlot.fromJson(e))
              .toList(),
      thursday: json['thursday'] is String
          ? json['thursday']
          : (json['thursday'] as List)
              .map((e) => TimeSlot.fromJson(e))
              .toList(),
      friday: json['friday'] is String
          ? json['friday']
          : (json['friday'] as List).map((e) => TimeSlot.fromJson(e)).toList(),
      saturday: json['saturday'] is String
          ? json['saturday']
          : (json['saturday'] as List)
              .map((e) => TimeSlot.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sunday': sunday is String
          ? sunday
          : (sunday as List<TimeSlot>).map((e) => e.toMap()).toList(),
      'monday': monday is String
          ? monday
          : (monday as List<TimeSlot>).map((e) => e.toMap()).toList(),
      'tuesday': tuesday is String
          ? tuesday
          : (tuesday as List<TimeSlot>).map((e) => e.toMap()).toList(),
      'wednesday': wednesday is String
          ? wednesday
          : (wednesday as List<TimeSlot>).map((e) => e.toMap()).toList(),
      'thursday': thursday is String
          ? thursday
          : (thursday as List<TimeSlot>).map((e) => e.toMap()).toList(),
      'friday': friday is String
          ? friday
          : (friday as List<TimeSlot>).map((e) => e.toMap()).toList(),
      'saturday': saturday is String
          ? saturday
          : (saturday as List<TimeSlot>).map((e) => e.toMap()).toList(),
    };
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

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }
}
