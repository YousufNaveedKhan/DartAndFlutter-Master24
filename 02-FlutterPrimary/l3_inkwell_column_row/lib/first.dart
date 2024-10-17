import 'package:flutter/material.dart';

void main() {
  runApp(const First());
}

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Yousuf"),
            Text("Muneeb"),
            Text("Khuzaima"),
            Text("Huzaifa"),
            Text("Afzal"),
            Text("Shoaib"),
            Text("Saaria"),
            Text("Ebaad"),
            ElevatedButton(onPressed: () {}, child: Text("Next")),
            ElevatedButton(onPressed: () {}, child: Text("Next")),
            ElevatedButton(onPressed: () {}, child: Text("Next")),
            ElevatedButton(onPressed: () {}, child: Text("Next")),
            ElevatedButton(onPressed: () {}, child: Text("Next")),
            ElevatedButton(onPressed: () {}, child: Text("Next")),
            ElevatedButton(onPressed: () {}, child: Text("Next Screen")),
          ],
        ),
      )),
    );
  }
}