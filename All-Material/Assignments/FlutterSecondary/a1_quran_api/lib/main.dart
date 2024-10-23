import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => Surahs()
          ))
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset("assets/images/quran.png")
      ),
    );
  }
}

class Surahs extends StatefulWidget {
  const Surahs({super.key});

  @override
  State<Surahs> createState() => _SurahsState();
}

class _SurahsState extends State<Surahs> {
  late Map mapresp;
  late List listresp = [];

  Future CallingAPI() async {
    http.Response response =
        await http.get(Uri.parse("https://api.alquran.cloud/v1/meta"));


        if (response.statusCode == 200) {
          mapresp = jsonDecode(response.body);
          listresp = mapresp["data"]["surahs"]["references"];
        }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CallingAPI();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listresp.isNotEmpty ? ListView.builder(
        itemCount: listresp == null ? 0 : listresp.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => DetailSurah(index + 1)
                ));
            },
            leading: CircleAvatar(
              backgroundColor: Colors.indigo[900],
              radius: 30,
              child: Text(
                listresp[index]["number"].toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(listresp[index]["name"] + " | " + listresp[index]["englishName"], style: GoogleFonts.amiriQuran(),),
            subtitle: Text(listresp[index]["englishNameTranslation"], style: GoogleFonts.amiriQuran(),),
            trailing: Text("Verses\n" + listresp[index]["numberofAyahs"].toString()),

          );
        }
        )
        : Center(child: CircularProgressIndicator()),
    );
  }
}

class DetailSurah extends StatefulWidget {
  const DetailSurah(int i, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}