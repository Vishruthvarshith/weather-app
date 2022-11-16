import 'dart:convert';

import'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: APIthing()
    );
  }
}

class APIthing extends StatefulWidget {
  const APIthing({Key? key}) : super(key: key);

  @override
  State<APIthing> createState() => _APIthingState();
}

class _APIthingState extends State<APIthing> {
  @override
  String city='';
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App",style: TextStyle(color: Colors.grey),),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(future: APIcall(),builder: (context,snapshot){
              if (snapshot.hasData){
                return
                  Column(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      Text("Weather: "+snapshot.data['weather'][0]['description'].toString()),
                      Text("Temperature: "+snapshot.data['main']['temp'].toString()+" degrees Celcius")

                    ],
                );
              }else {
                return CircularProgressIndicator();
              }
            }
            ),
          ],
        )
    );
  }
}

Future APIcall() async {
  var url = Uri.parse("https://api.openweathermap.org/data/2.5/"
      "weather?q=london&appid=3ffeeecbf5d2aabcd2d01ed0a0999871&units=metric");
  final response=await http.get(url);
  final json= jsonDecode(response.body);
  return json;
}