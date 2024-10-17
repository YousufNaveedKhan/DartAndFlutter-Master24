import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'secondpage.dart';
import 'thirdpage.dart';
void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.indigo,
        child: Column(children: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()
            ),
            );
          }, child: Text(
            "First Page",
            style: TextStyle(color: Colors.black),
            ),
            ),
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()
            ),
            );
          }, child: Text(
            "Second Page",
            style: TextStyle(color: Colors.black),
            ),
            ),
          OutlinedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()
            ),
            );
          }, child: Text(
            "Third Page",
            style: TextStyle(color: Colors.black),
            ),
            ),
        ],)
      )
    );
  }
}