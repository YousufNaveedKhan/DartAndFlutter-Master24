import 'package:flutter/material.dart';

void main() {
  runApp(const SecondPage());
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: 
    Text(
      "Second Page",
      style: TextStyle(fontSize: 30, color: Colors.green),
      ),
      );
  }
}