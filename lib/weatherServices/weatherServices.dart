import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response =
        await http.get(Uri.parse('$BASE_URL?q=$cityName&APPID=$apiKey'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
      print("success");
    } else {
      throw Exception("Failed to load Weather data");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
