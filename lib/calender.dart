import 'package:flutter/material.dart';
import 'package:epichub/alertpage.dart';
import 'package:epichub/duedate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<Calendar> {
  late final ValueNotifier<DateTime> _focusedDay;
  late DateTime _selectedDay;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(DateTime.now());
    _selectedDay = DateTime.now();
    _updateDay();
  }

  void _updateDay() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      if (now.day != _focusedDay.value.day) {
        setState(() {
          _focusedDay.value = now;
          _selectedDay = now;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _showDueDates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Showing due dates!')),
    );
  }

  void _navigateToAlertPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlertPage()),
    );
  }

  void _navigateToDueDatesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DueDatesPage()), // Navigate to DueDates page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay.value,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay.value = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: _navigateToAlertPage,
                iconSize: 50.0,
                color: Colors.red,
              ),
              const Text('Alert Tenant'),
            ],
          ),
          const SizedBox(height: 20), // Adjusting spacing
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _navigateToDueDatesPage, // Navigate to DueDates page
                iconSize: 50.0,
                color: Colors.blue,
              ),
              const Text('Show Due Dates'),
            ],
          ),
        ],
      ),
    );
  }
}
