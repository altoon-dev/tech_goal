import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/weather/weather_service.dart';
import '../authentication/widgets/custom_elevated_button.dart';
import '../welcome/welcome_eugene.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({Key? key}) : super(key: key);

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = 'Saratov';
  int _temperature = 0;
  Timer? _timer;
  final WeatherModel _weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    _cityController.text = _cityName;
    _updateWeatherForCity(_cityName);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _updateWeatherForCity(_cityName);
    });
  }

  Future<void> _updateWeatherForCity(String cityName) async {
    var weatherData = await _weatherModel.getCityWeather(cityName);
    if (weatherData != null) {
      _updateUI(weatherData);
    }
  }

  void _updateUI(dynamic weatherData) {
    setState(() {
      _temperature = (weatherData['main']['temp'] as num).toInt();
      _cityName = weatherData['name'];
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeEugene()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _cityName,
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
            Text(
              '$_temperature°',
              style: const TextStyle(fontSize: 60, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  hintText: 'Enter a city name',
                  fillColor: Colors.transparent,
                  filled: true,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            CustomElevatedButton(
              onPressed: () {
                final cityName = _cityController.text;
                _cityName = cityName;
                _updateWeatherForCity(cityName);
              },
              text: 'Get Weather',
            ),
          ],
        ),
      ),
    );
  }
}
