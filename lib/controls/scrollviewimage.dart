import 'package:flutter/material.dart';
import 'package:stop_watch/resources/imagestring.dart';

class ScrollImageDisp extends StatefulWidget {
  const ScrollImageDisp({super.key});

  @override
  State<ScrollImageDisp> createState() => _ScrollImageDispState();
}

class _ScrollImageDispState extends State<ScrollImageDisp> {
  Widget ScrollDisp() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: i2.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Image.asset(
              i2[index],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ScrollDisp()));
  }
}
