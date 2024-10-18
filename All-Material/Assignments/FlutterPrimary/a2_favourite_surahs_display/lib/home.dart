import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var surahEngName = [
    "Surah Al-Fatiha",
    "Surah Al-Kahf",
    "Surah As-Sajdah",
    "Surah Yaseen",
    "Surah Ar-Rahman",
    "Surah Al-Waqi'ah",
    "Surah Al-Mulk",
    "Surah At-Tariq"
  ];

  var surahUrduNames = [
    "الفاتحة",
    "الكهف",
    "السجدة",
    "يس",
    "الرحمن",
    "الواقعة",
    "الملك",
    "الطارق"
  ];

  var surahMeanings = [
    "The Opening",
    "The Cave",
    "The Prostration",
    "Ya Sin",
    "The Beneficent",
    "The Event",
    "The Sovereignty",
    "The Morning Star"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(itemBuilder: (context, index) {
        return ListTile(
          title: Text(surahEngName[index], style: TextStyle(fontSize: 20, color
          : Colors.black)),
          subtitle: Text(surahUrduNames[index], style: TextStyle(fontSize: 18,
          color: Colors.grey)),
          trailing: Text(surahMeanings[index], style: TextStyle(fontSize: 18, color
          : Colors.grey)),
          onTap: () {
            // Navigate to the next screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SurahDetail(surahEngName[index], surahUrduNames[index], surahMeanings[index])),
              );
              }
  
        );
      }
      , separatorBuilder: (context, index) {
        return Divider(height: 1, color: Colors.grey[300]);
      },
      itemCount: surahEngName.length),
    );
  }
}

class SurahDetail extends StatefulWidget {
  var engName;
  var urduName;
  var meaning;
  SurahDetail(this.engName, this.urduName, this.meaning, {super.key});

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    ListView.builder(itemBuilder: 
    (context, index) {
      return ListTile(
        title: Text(widget.engName, style: TextStyle(fontSize: 20, color: Colors.black)),
        subtitle: Text(widget.urduName, style: TextStyle(fontSize: 18, color: Colors.black87)),
        trailing: Text(widget.meaning, style: TextStyle(fontSize: 18, color: Colors.black)),
        );
    },
    itemCount: 1
    ),
        );
  }
}

