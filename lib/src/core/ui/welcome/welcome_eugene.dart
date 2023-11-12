import 'package:flutter/material.dart';
import 'package:tech_goal/src/core/ui/calculator/calculator.dart';
import 'package:tech_goal/src/core/ui/weather/weather_report.dart';

class WelcomeEugene extends StatefulWidget {
  const WelcomeEugene({super.key});

  @override
  State<WelcomeEugene> createState() => _WelcomeEugeneState();
}

class _WelcomeEugeneState extends State<WelcomeEugene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome Eugene!',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const CalculatorView()),
                      );
                    },
                    child: const Text(
                      'Calculator',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  const WeatherReport()),
                      );
                    },
                    child: const Text(
                      'Weather Report',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
