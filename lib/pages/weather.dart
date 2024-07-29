import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

/// The WeatherPage displays weather information retrieved from an API.
class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _weatherInfo = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  /// Fetches weather information from a weather API.
  Future<void> _fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.4050&current_weather=true'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final temperature = data['current_weather']['temperature'];
        setState(() {
          _weatherInfo = 'Current temperature: $temperature°C';
        });
      } else {
        setState(() {
          _weatherInfo = 'Failed to load weather data';
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: Center(
        child: Text(_weatherInfo, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
