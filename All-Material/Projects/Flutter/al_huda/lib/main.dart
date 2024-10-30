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
    Timer(const Duration(seconds: 3), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SurahIndex()));
    }));
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
                              IconButton(
                                icon: Icon(Icons.book, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Center(child: Text('Tafseer will be uploaded soon!')),
                                    ),
                                  );
                                },
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
      final response = await http.get(Uri.parse("https://api.alquran.cloud/v1/surah/${snum}"));

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
      final response = await http.get(Uri.parse("http://api.alquran.cloud/v1/surah/$surahNumber/en.asad"));
      if (response.statusCode == 200) {
        final translationMap = jsonDecode(response.body);
        englishTranslations = translationMap["data"]["ayahs"].map((ayah) => ayah["text"]).toList();
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

  Future<void> playAyah(int ayahIndex) async {
    if (listresp.isNotEmpty) {
      try {
        final audioUrl = listresp[ayahIndex]['audio'];
        print("Playing audio from: $audioUrl"); // Log the audio URL
        await audioPlayer.setUrl(audioUrl);
        await audioPlayer.play();

        setState(() {
          currentlyPlayingIndex = ayahIndex;
        });

        audioPlayer.playerStateStream.listen((state) {
          if (!state.playing) {
            setState(() {
              currentlyPlayingIndex = null;
            });
          }
        });
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
  }

  Future<void> togglePlayPause(int ayahIndex) async {
    if (currentlyPlayingIndex == ayahIndex) {
      audioPlayer.pause();
      setState(() {
        currentlyPlayingIndex = null;
      });
    } else {
      if (currentlyPlayingIndex != null) {
        audioPlayer.stop();
      }
      await playAyah(ayahIndex);
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
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
        body: TabBarView(
          children: [
            listresp.isNotEmpty && englishTranslations.isNotEmpty
                ? ListView.builder(
                    itemCount: listresp.length,
                    itemBuilder: (context, index) {
                      bool isPlaying = currentlyPlayingIndex == index;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: ListTile(
                          title: Text(
                            listresp[index]["text"],
                            style: GoogleFonts.amiriQuran(),
                            textDirection: TextDirection.rtl,
                          ),
                          subtitle: Text(
                            englishTranslations[index],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                              color: Colors.green,
                              size: 32,
                            ),
                            onPressed: () => togglePlayPause(index),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.book, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Center(
                                      child: Text('Tafseer Tab Content')),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            const Center(child: Text('Bookmarks Tab Content')),
            const Center(child: Text('Tafseer Tab Content')),
          ],
        ),
      ),
    );
  }
}



class BookmarksTab extends StatelessWidget {
  final List<int> bookmarkedSurahs;
  final List allSurahs;

  const BookmarksTab(
      {Key? key, required this.bookmarkedSurahs, required this.allSurahs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookmarkedSurahs.length,
      itemBuilder: (context, index) {
        int surahIndex = bookmarkedSurahs[index] - 1;
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailSurah(bookmarkedSurahs[index]),
              ),
            );
          },
          title: Text(
            "${allSurahs[surahIndex]["name"]} | ${allSurahs[surahIndex]["englishName"]}",
            style: GoogleFonts.amiriQuran(),
          ),
          subtitle: Text(allSurahs[surahIndex]["englishNameTranslation"] ?? ''),
        );
      },
    );
  }
}

