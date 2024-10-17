import 'package:flutter/material.dart';

void main() {
  runApp(const Second());
}

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text("Yousuf"),
          Text("Misbah"),
          Text("Sana"),
          Text("Muneeb"),
          Text("Saaria"),
          Text("Ebaad"),
          Text("Khuzaima"),
          Text("Huzaifa"),
          ElevatedButton(onPressed: () {}, child: Text("Next")),
          ElevatedButton(onPressed: () {}, child: Text("Next")),
          ElevatedButton(onPressed: () {}, child: Text("Next")),
          ElevatedButton(onPressed: () {}, child: Text("Next")),
        ],
      ),
    );
  }
}