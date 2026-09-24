import 'dart:async';
import 'package:flutter/material.dart';

class MyStopwatch extends StatefulWidget {
  const MyStopwatch({super.key});

  @override
  State<MyStopwatch> createState() => StopwatchState();
}

class StopwatchState extends State<MyStopwatch> {
  final Stopwatch stopwatch = Stopwatch();
  final List<int> laps = <int>[];

  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    if (!isRunning) {
      stopwatch.start();

      timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
        setState(() {});
      });

      setState(() {
        isRunning = true;
      });
    }
  }

  void stopTimer() {
    if (isRunning) {
      stopwatch.stop();
      timer?.cancel();

      setState(() {
        isRunning = false;
      });
    }
  }

  void resetTimer() {
    stopwatch.reset();
    laps.clear();
    debugPrint(laps.toString());
    setState(() {});
  }

  void recordLap() {
    setState(() {
      laps.add(stopwatch.elapsedMilliseconds);
    });
    debugPrint(laps.toString());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime() {
    final elapsed = stopwatch.elapsedMilliseconds;
    final seconds = elapsed / 1000;

    return seconds.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formatTime(),
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _actionButton(
                      label: "Start",
                      color: Colors.green,
                      onPressed: startTimer,
                    ),
                    _actionButton(
                      label: "Stop",
                      color: Colors.red,
                      onPressed: stopTimer,
                    ),
                    _actionButton(
                      label: "Lap",
                      color: Colors.orange,
                      onPressed: recordLap,
                    ),
                    _actionButton(
                      label: "Reset",
                      color: Colors.blue,
                      onPressed: resetTimer,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _lapCounter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _lapCounter() {
    return Text(
      'Lap: ${laps.length + 1}',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _actionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        child: Text(label),
      ),
    );
  }
}
