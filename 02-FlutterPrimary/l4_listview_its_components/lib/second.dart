import 'package:flutter/material.dart';

void main() {
  runApp(const Second());
}

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  var students = [
    "Shahzaib",
    "Jhangir",
    "Shehbaz",
    "Suresh",
    "Kumar",
    "John",
    "Bob",
    "Olivia"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
              child: Card(
                  child: ListTile(
                      title: Text(students[index]),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              students.removeAt(index);
                            });
                          }))));
        },
        itemCount: students.length,
        itemExtent: 50,
      ),
    );
  }
}
