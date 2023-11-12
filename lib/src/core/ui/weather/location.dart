import 'package:flutter/material.dart';
import 'package:tech_goal/src/core/services/weather/weather_service.dart';

class Locations extends StatefulWidget {
  const Locations({super.key, this.locationWeather});

  final locationWeather;

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  late int temperature;
  late int condition;
  late String cityName;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        cityName = '';
        return;
      }
      double temp = weather['main']['temp'];
      temperature = temp.toInt();
      cityName = weather['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                var weatherData = await weatherModel.getCityWeather(cityName);
                updateUI(weatherData);
              },
              child: const Text(
                'Get Weather',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$temperature°',
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  cityName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
