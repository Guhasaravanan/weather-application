import 'package:flutter/material.dart';
import 'package:flutter_application_1/weatherServices/weatherServices.dart';
import 'package:lottie/lottie.dart';

import '../model/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('cd50784bf57b587152bcdf6a0c3089b9');

  Weather? _weather;

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assests/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assests/cloudy.json';

      case 'rain':
      case 'drzzle':
      case 'shower rain':
        return 'assests/rainny.json';

      case 'thunderstorm':
        return 'assests/thunder.json';

      case 'clear':
        return 'assests/sunny.json';

      default:
        return 'assests/sunny.json';
    }
  }

  _fetchMethod() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      print("cccc" + cityName);
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city.."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text("${_weather?.temperature}°C"),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
