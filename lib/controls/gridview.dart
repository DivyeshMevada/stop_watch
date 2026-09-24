import 'package:flutter/material.dart';
import 'package:stop_watch/resources/imagestring.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewState();
}

class _GridViewState extends State<GridViewScreen> {
  Widget _gridDisp() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: i2.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Image.asset(i2[index], fit: BoxFit.cover);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grid View")),
      body: _gridDisp(),
    );
  }
}
