import 'package:flutter/material.dart';

void main() {
  runApp(const Third());
}

class Third extends StatefulWidget {
  const Third({Key? key}) : super(key: key);

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              height: 200,
              width: 200,
              color: Colors.amber,
              child: Center(
                child: Text("Back"),
              )),
        ),
      ),
    );
  }
}