import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  Weather({Key key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Berlin&units=metric&appid=3330a4541fe0daaba0b0544dd82c78b4");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windspeed = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 50),
                  child: Text(
                    "Currenlty in Berlin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  temp.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Temperature"),
                trailing: Text("$temp\u00B0"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text("$description"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing: Text("$humidity"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("WindSpeed"),
                trailing: Text("$windspeed"),
              ),
            ]),
          ))
        ],
      ),
    );
  }
}
