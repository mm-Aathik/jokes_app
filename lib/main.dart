import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String apiUrl = "https://official-joke-api.appspot.com/jokes/random";
  String setup = "";
  String punchline = "";

  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  Future<void> fetchJoke() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jokeData = json.decode(response.body);
        setState(() {
          setup = jokeData['setup'];
          punchline = jokeData['punchline'];
        });
      } else {
        print("Failed to fetch joke. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Joke App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          
          leading: Icon(Icons.menu, color: Colors.white),
          actions: [
            Icon(Icons.search, color: Colors.white),
            Icon(Icons.more_vert, color: Colors.white),
          ],
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: fetchJoke,
                child: Text(
                  'Get Joke',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ) 
              ),
              Text(
                "Joke:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                setup,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                punchline,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
