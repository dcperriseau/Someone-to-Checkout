import 'package:flutter/material.dart';
import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/pages/payment/payment_screen.dart';

class BookingDetailsPage extends StatefulWidget {
  final int amount;
  final String description;
  final AvailableTimes availableTimes;

  const BookingDetailsPage({
    Key? key,
    required this.amount,
    required this.description,
    required this.availableTimes,
  }) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String? _selectedTime;
  String? _timeError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              SizedBox(height: 16),
              Text('Select a time:'),
              DropdownButtonFormField<String>(
                items: [
                  for (final time in widget.availableTimes.toList())
                    DropdownMenuItem(
                      value: time,
                      child: Text(time),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedTime = value;
                    _timeError = null;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a time';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorText: _timeError,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_isValidTime(_selectedTime)) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            amount: widget.amount,
                            currency: 'usd',
                            description: widget.description,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        _timeError = 'Selected time is not available. Please select a valid time slot.';
                      });
                    }
                  }
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidTime(String? selectedTime) {
    if (selectedTime == null) return false;
    final times = widget.availableTimes.toList();
    return times.contains(selectedTime);
  }
}

extension on AvailableTimes {
  List<String> toList() {
    final times = <String>[];
    if (sunday != null && sunday is List<TimeSlot>) {
      times.addAll((sunday as List<TimeSlot>).map((e) => 'Sunday: ${e.start} - ${e.end}'));
    }
    if (monday != null && monday is List<TimeSlot>) {
      times.addAll((monday as List<TimeSlot>).map((e) => 'Monday: ${e.start} - ${e.end}'));
    }
    if (tuesday != null && tuesday is List<TimeSlot>) {
      times.addAll((tuesday as List<TimeSlot>).map((e) => 'Tuesday: ${e.start} - ${e.end}'));
    }
    if (wednesday != null && wednesday is List<TimeSlot>) {
      times.addAll((wednesday as List<TimeSlot>).map((e) => 'Wednesday: ${e.start} - ${e.end}'));
    }
    if (thursday != null && thursday is List<TimeSlot>) {
      times.addAll((thursday as List<TimeSlot>).map((e) => 'Thursday: ${e.start} - ${e.end}'));
    }
    if (friday != null && friday is List<TimeSlot>) {
      times.addAll((friday as List<TimeSlot>).map((e) => 'Friday: ${e.start} - ${e.end}'));
    }
    if (saturday != null && saturday is List<TimeSlot>) {
      times.addAll((saturday as List<TimeSlot>).map((e) => 'Saturday: ${e.start} - ${e.end}'));
    }
    return times;
  }
}
