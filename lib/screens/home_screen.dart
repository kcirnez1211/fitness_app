import 'package:fitness_app/screens/exercise_hub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiURL =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  late ExerciseHub exerciseHub;
  @override
  void initState() {
    getExercises();
    super.initState();
  }

  void getExercises() async {
    final response = await http.get(Uri.parse(apiURL));
    var body = response.body;
    var decodedJson = jsonDecode(body);
    exerciseHub = ExerciseHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        child: exerciseHub != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: FadeInImage(
                      image:
                          NetworkImage(exerciseHub.exercises[index].thumbnail),
                      placeholder: AssetImage("assets/placeholder.jpg"),
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: exerciseHub.exercises.length,
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}
