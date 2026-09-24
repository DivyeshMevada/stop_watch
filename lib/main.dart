import 'package:flutter/material.dart';
// import 'package:stop_watch/controls/scrollviewimage.dart';
import 'package:stop_watch/controls/techfestapp.dart';
// import 'package:stop_watch/controls/gridview.dart';
// import 'package:stop_watch/controls/scrollviewimage.dart';
// import 'package:stop_watch/devills/stopwatch.dart';
// import 'package:stop_watch/controls/imagesdisp.dart';
// import 'package:stop_watch/devills/registrationform.dart';
// import 'package:stop_watch/devills/1.dart';
// import 'package:stop_watch/devills/calendarExample.dart';
// import 'package:stop_watch/devills/registrationform.da/rt';
// import 'package:stop_watch/devills/checkbox.dart';
// import 'package:stop_watch/devills/sliderExample.dart';
// import 'package:stop_watch/devills/loginscreen.dart';
// import 'stopwatch/stopwatch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TechFest(),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Registration Form',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const RegistrationPage(),
//     );
//   }
// }
