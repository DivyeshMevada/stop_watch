import 'package:flutter/material.dart';

class CheckBoxDemo extends StatefulWidget {
  const CheckBoxDemo({super.key});

  @override
  State<CheckBoxDemo> createState() => _CheckBoxDemoState();
}

class _CheckBoxDemoState extends State<CheckBoxDemo> {
  bool _isChecked = false;
  void setCheckBox() {
    setState(() {
      _isChecked = _isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            CheckboxListTile(
              title: const Text('check me '),
              value: _isChecked,
              onChanged: (v) => setState(() {
                _isChecked = v!;
              }),
            ),
            Text(_isChecked ? 'Checked' : 'Unchecked'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: setCheckBox,
              child: const Text('Check Box'),
            ),
          ],
        ),
      ),
    );
  }
}
