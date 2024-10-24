import 'package:flutter/material.dart';

void main() {
  runApp(const Third());
}

class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  var students = [
    "hiba",
    "sana",
    "misbah",
    "annum",
    "sir yousuf",
    "muneeba",
    "saaria youtuber",
    "ebad"
  ];

  var mycolor = [
    Colors.teal,
    Colors.teal[900],
    Colors.black,
    Colors.indigo[900],
    Colors.purple[900],
    Colors.blue,
    Colors.teal,
    Colors.teal[900]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(students[index])));
              },
              leading: CircleAvatar(
                backgroundColor: mycolor[index],
                child: Text(index.toString()),
                radius: 30,
              ),
              title: Text(students[index]),
              subtitle: Text("Busy..."),
              trailing: Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                Icon(Icons.edit),
              ],
              ),

            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 20,
              thickness: 1,
            );
          },
          itemCount: students.length),
    );
  }
}

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  var name;
  Detail(this.name, {super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(widget.name));
  }
}