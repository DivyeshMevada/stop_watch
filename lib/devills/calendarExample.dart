import 'package:flutter/material.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({super.key});

  @override
  State<CalendarExample> createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  DateTime? data;
  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked != null && picked != data) {
      setState(() {
        data = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = data == null
        ? 'No date selected'
        : 'Selected date: ${data!.day}/${data!.month}/${data!.year}';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(onPressed: pickDate, child: const Text('set Date')),
          ],
        ),
      ),
    );
  }
}
