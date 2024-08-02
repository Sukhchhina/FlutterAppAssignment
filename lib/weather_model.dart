// weather_model.dart
class Weather {
  final String description;
  final double temperature;
  final double windSpeed;
  final int humidity;
  final String icon;

  Weather({
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
    );
  }
}
