import 'package:flutter/material.dart';

void main() {
  runApp(const First());
}

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
          ElevatedButton(onPressed: () {}, child: Text("Button 1")),
          ElevatedButton(onPressed: () {}, child: Text("Button 2")),
          ElevatedButton(onPressed: () {}, child: Text("Button 3")),
          Text("Muneeb"),
          ElevatedButton(onPressed: () {}, child: Text("Button 4")),
          ]
        ),
      )
    );
  }
}