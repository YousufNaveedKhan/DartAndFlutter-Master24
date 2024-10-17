import 'package:flutter/material.dart';

void main() {
  runApp(const ThirdPage());
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: 
    Text(
      "Third Page",
      style: TextStyle(fontSize: 30, color: Colors.red),
      ),
      );
  }
}