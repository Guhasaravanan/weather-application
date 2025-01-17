class Weather {
  final String cityName;
  final String temperature;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.mainCondition,
      required this.temperature});

factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(
    cityName: json['name'],
    mainCondition: json['weather'][0]['main'],
    temperature: (json['main']['temp'] - 273.15).toStringAsFixed(1), // Convert Kelvin to Celsius
  );
}

}
