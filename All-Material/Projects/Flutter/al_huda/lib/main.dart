import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Huda - القرآن',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.amiriTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScr(),
    );
  }
}

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SurahIndex()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff010D26),
                Color.fromARGB(255, 2, 115, 30),
              ],
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Al-Huda",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "jameel",
                    fontSize: 40,
                    color: Color(0XFFF2F2F2),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "القرآن",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "jameel",
                    fontSize: 40,
                    color: Color(0XFFF2F2F2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SurahIndex extends StatefulWidget {
  const SurahIndex({super.key});

  @override
  State<SurahIndex> createState() => _SurahIndexState();
}

class _SurahIndexState extends State<SurahIndex> {
  late Map mapresp;
  late List listresp = [];
  List<int> bookmarkedSurahs = [];

  Future<void> callapi() async {
    try {
      final response =
          await http.get(Uri.parse("https://api.alquran.cloud/v1/meta"));

      if (response.statusCode == 200) {
        setState(() {
          mapresp = jsonDecode(response.body);
          listresp = mapresp["data"]["surahs"]["references"] ?? [];
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    callapi();
  }

  void toggleBookmark(int index) {
    setState(() {
      if (bookmarkedSurahs.contains(index)) {
        bookmarkedSurahs.remove(index);
      } else {
        bookmarkedSurahs.add(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Surah added to bookmarks')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Al-Huda Quran App', style: GoogleFonts.amiriQuran()),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Quran'),
              Tab(text: 'Bookmarks'),
              Tab(text: 'Tafseer'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Center(
                  child: Text(
                    'Al-Huda',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                title: Text('About'),
                onTap: () {},
              ),
              ListTile(
                title: Text('FAQ'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            listresp.isNotEmpty
                ? ListView.builder(
                    itemCount: listresp.length,
                    itemBuilder: (context, index) {
                      bool isBookmarked = bookmarkedSurahs.contains(index + 1);
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSurah(index + 1),
                              ),
                            );
                          },
                          title: Text(
                            "${listresp[index]["name"]} | ${listresp[index]["englishName"]}",
                            style: GoogleFonts.amiriQuran(),
                          ),
                          subtitle: Text(
                              listresp[index]["englishNameTranslation"] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: isBookmarked ? Colors.green : null,
                                ),
                                onPressed: () => toggleBookmark(index + 1),
                              ),
                            ],
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 30,
                              child: Text(
                                listresp[index]["number"].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            BookmarksTab(
                bookmarkedSurahs: bookmarkedSurahs, allSurahs: listresp),
            const Center(child: Text('Tafseer will be uploaded soon!')),
          ],
        ),
      ),
    );
  }
}

class DetailSurah extends StatefulWidget {
  final int indexnumber;
  const DetailSurah(this.indexnumber, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  late Map mapresp;
  late List listresp = [];
  late List englishTranslations = [];
  late AudioPlayer audioPlayer;
  int? currentlyPlayingIndex;

  Future<void> callApi() async {
    int snum = widget.indexnumber;
    try {
      final response = await http
          .get(Uri.parse("https://api.alquran.cloud/v1/surah/${snum}"));

      if (response.statusCode == 200) {
        setState(() {
          mapresp = jsonDecode(response.body);
          listresp = mapresp["data"]["ayahs"] ?? [];
        });

        // Fetch English translation
        await fetchEnglishTranslation(snum);
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("API call error: $e");
    }
  }

  Future<void> fetchEnglishTranslation(int surahNumber) async {
    try {
      final response = await http.get(
          Uri.parse("http://api.alquran.cloud/v1/surah/$surahNumber/en.asad"));
      if (response.statusCode == 200) {
        final translationMap = jsonDecode(response.body);
        setState(() {
          englishTranslations = translationMap["data"]["ayahs"]
              .map((ayah) => ayah["text"])
              .toList();
        });
      } else {
        print("Error fetching English translation: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching English translation: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    callApi();
  }

  Future<void> playAyah(int index) async {
    if (listresp.isNotEmpty && index < listresp.length) {
      String audioUrl = listresp[index]["audio"];

      try {
        if (currentlyPlayingIndex == index) {
          // If the same ayah is playing, toggle pause/play
          if (audioPlayer.playing) {
            await audioPlayer.pause();
          } else {
            await audioPlayer.play();
          }
        } else {
          // Play new ayah
          await audioPlayer.setUrl(audioUrl);
          await audioPlayer.play();
          setState(() {
            currentlyPlayingIndex = index;
          });
        }
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayat Detail')),
      body: listresp.isNotEmpty
          ? ListView.builder(
              itemCount: listresp.length,
              itemBuilder: (context, index) {
                bool isPlaying = currentlyPlayingIndex == index;

                return Card(
                  child: ListTile(
                    trailing: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(listresp[index]["numberInSurah"].toString(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(
                      listresp[index]["text"],
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiriQuran(fontSize: 18),
                    ),
                    subtitle: Text(
                      englishTranslations.isNotEmpty
                          ? englishTranslations[index]
                          : '',
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.nunito(fontSize: 15),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: isPlaying ? Colors.green : null,
                      ),
                      onPressed: () => playAyah(index),
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class BookmarksTab extends StatelessWidget {
  final List<int> bookmarkedSurahs;
  final List allSurahs;

  const BookmarksTab(
      {super.key, required this.bookmarkedSurahs, required this.allSurahs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookmarkedSurahs.length,
      itemBuilder: (context, index) {
        int surahIndex = bookmarkedSurahs[index] - 1;
        return ListTile(
          title: Text(allSurahs[surahIndex]["englishName"] ?? ''),
          subtitle: Text(allSurahs[surahIndex]["englishNameTranslation"] ?? ''),
          trailing: const Icon(Icons.bookmark),
        );
      },
    );
  }
}
