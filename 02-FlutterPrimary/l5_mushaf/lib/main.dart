import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
        Duration(seconds: 3),
        () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Screen())),
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset("assets/images/quran.png"),
      ),
    ));
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Surahs(),
                ));
          },
          child: Text("Quran"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Recitation(),
                ));
          },
          child: Text("Recitation"),
        ),
      ],
    )));
  }
}

class Surahs extends StatefulWidget {
  const Surahs({super.key});

  @override
  State<Surahs> createState() => _SurahsState();
}

class _SurahsState extends State<Surahs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailSurah(index + 1)),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Colors.brown[900],
                child:
                    Text("${index + 1}", style: TextStyle(color: Colors.white)),
              ),
              title: Text(
                  quran.getSurahName(index + 1) +
                      " | " +
                      quran.getSurahNameArabic(index + 1),
                  style: GoogleFonts.amiriQuran()),
              subtitle: Text(quran.getSurahNameEnglish(index + 1)),
              trailing: Column(
                children: [
                  quran.getPlaceOfRevelation(index + 1) == 'Makkah'
                      ? Image.asset(
                          "assets/images/kaaba.png",
                          width: 30,
                          height: 30,
                        )
                      : Image.asset(
                          "assets/images/madina.png",
                          width: 30,
                          height: 30,
                        ),
                  Text("Verses" + quran.getVerseCount(index + 1).toString(),
                      style: TextStyle(fontSize: 10))
                ],
              ),
            );
          },
          itemCount: quran.totalSurahCount),
    );
  }
}

class DetailSurah extends StatefulWidget {
  var index;
  DetailSurah(this.index, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: quran.getVerseCount(widget.index),
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(
                quran.getVerse(widget.index, index + 1, verseEndSymbol: true),
                textAlign: TextAlign.right,
                style: GoogleFonts.amiriQuran(),
              ));
            }));
  }
}

class Recitation extends StatefulWidget {
  const Recitation({super.key});

  @override
  State<Recitation> createState() => _RecitationState();
}

class _RecitationState extends State<Recitation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahRecitation(index + 1)));
          },
          leading: CircleAvatar(
            backgroundColor: Colors.teal[900],
            child: Text(
              "${index + 1}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            quran.getSurahName(index + 1) +
                " | " +
                quran.getSurahNameArabic(index + 1),
            style: GoogleFonts.amiriQuran(),
          ),
          subtitle: Text(
            "مشاري بن راشد العفاسي",
            style: GoogleFonts.amiriQuran(
                textStyle: TextStyle(color: Colors.teal)),
          ),
          trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                quran.getPlaceOfRevelation(index + 1) == 'Makkah'
                    ? Image.asset("assets/images/kaaba.png",
                        width: 30, height: 30)
                    : Image.asset("assets/images/madina.png",
                        width: 30, height: 30),
                Text("Verses" + quran.getVerseCount(index+1).toString(),
                style: TextStyle(fontSize: 10),
                )
              ]),
        );
        
      },
      itemCount: 114,
      ),
    );
  }
}

class SurahRecitation extends StatefulWidget {
    var indexSurah;
    SurahRecitation(this.indexSurah, {super.key});
  
    @override
    State<SurahRecitation> createState() => _SurahRecitationState();
  }
  
  class _SurahRecitationState extends State<SurahRecitation> {
    AudioPlayer audioPlayer = AudioPlayer();
    IconData playpauseButton = Icons.play_circle_fill_rounded;
    bool isplaying = true;
  
    @override
    void dispose() {
      audioPlayer.dispose();
  
      super.dispose();
    }
  
    Future<void> togglebtn() async {
      try {
        final audioUrl = await quran.getAudioURLBySurah(widget.indexSurah);
        audioPlayer.setUrl(audioUrl);
  
        if (isplaying) {
          audioPlayer.play();
  
          setState(() {
            playpauseButton = Icons.pause_circle_filled_rounded;
            isplaying = false;
          });
        } else {
          audioPlayer.pause();
  
          setState(() {
            playpauseButton = Icons.play_circle_fill_rounded;
            isplaying = true;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "سورۃ " + quran.getSurahNameArabic(widget.indexSurah),
              style: GoogleFonts.amiriQuran(textStyle: TextStyle(fontSize: 30)),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Color(0xff272729),
                radius: 100,
                backgroundImage: AssetImage(
                  "assets/images/alaffasy.png",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: Color.fromARGB(255, 49, 13, 1),
              // height: double.infinity,
              child: Center(
                  child: IconButton(
                      onPressed: togglebtn,
                      icon: Icon(color: Colors.white, playpauseButton))),
            ),
          ],
        ),
      );
    }
  }