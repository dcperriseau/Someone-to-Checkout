import 'package:flutter/material.dart';

class TimeSlotSection extends StatefulWidget {
  final String day;
  final Map<String, bool> dayValues;
  final Function(String, String, String) onTimeSlotChanged;
  final Function(String) onDayCheckChanged;

  const TimeSlotSection({
    super.key,
    required this.day,
    required this.dayValues,
    required this.onTimeSlotChanged,
    required this.onDayCheckChanged,
  });

  @override
  TimeSlotSectionState createState() => TimeSlotSectionState();
}

class TimeSlotSectionState extends State<TimeSlotSection> {
  bool checked = false;
  String start = '';
  String end = '';

  List<String> timeOptions = [];

  @override
  initState() {
    super.initState();
    checked = widget.dayValues[widget.day]!;
  }

  List<String> _generateTimeOptions() {
    List<String> _timeOptions = [];
    for (int hour = 0; hour < 24; hour++) {
      String hourString = (hour % 12 == 0 ? 12 : hour % 12).toString();
      String amPm = hour < 12 ? 'AM' : 'PM';
      _timeOptions.add('$hourString:00 $amPm');
      _timeOptions.add('$hourString:30 $amPm'); // Adding 30-minute intervals
    }
    return _timeOptions;
  }

  @override
  Widget build(BuildContext context) {
    timeOptions = _generateTimeOptions();

    return LayoutBuilder(
      builder: (context, constraints) {
        double spacing = constraints.maxWidth < 600 ? 8.0 : 12.0;

        return Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: checked,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      checked = value;
                      widget.dayValues[widget.day] = checked;

                      if (!checked) {
                        start = '';
                        end = '';
                        widget.onDayCheckChanged(widget.day);
                      }
                    });
                  },
                ),
                Text(widget.day),
                SizedBox(width: spacing),
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text('Start Time'),
                    ),
                    items: timeOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    value: start.isEmpty ? null : start,
                    onChanged: !checked
                        ? null
                        : (String? value) {
                            if (value == null || value.isEmpty) return;
                            setState(() {
                              start = value;
                            });
                            widget.onTimeSlotChanged(widget.day, start, end);
                          },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacing),
                  child: Text('to'),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    items: timeOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    value: end.isEmpty ? null : end,
                    onChanged: !checked
                        ? null
                        : (String? value) {
                            if (value == null || value.isEmpty) return;
                            setState(() {
                              end = value;
                            });
                            widget.onTimeSlotChanged(widget.day, start, end);
                          },
                    decoration: const InputDecoration(
                      label: Text('End Time'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 0.5),
          ],
        );
      },
    );
  }
}
