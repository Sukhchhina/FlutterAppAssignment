// weather_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../weather_model.dart';
import 'package:go_router/go_router.dart';


class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final String apiKey = '76ee260ff8453e8849f226fc2d345c3a'; // Replace with your OpenWeather API key
  final String city = 'Toronto'; // Change to your desired city
  Weather? weather;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weather = Weather.fromJson(data);
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/greeting');
          },
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : weather != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather in $city',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://openweathermap.org/img/wn/${weather!.icon}@2x.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              '${weather!.temperature}°C',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 10),
            Text(
              weather!.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.air),
                SizedBox(width: 5),
                Text('Wind: ${weather!.windSpeed} m/s'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water),
                SizedBox(width: 5),
                Text('Humidity: ${weather!.humidity}%'),
              ],
            ),
          ],
        )
            : Text('Error fetching weather data.'),
      ),
    );
  }
}
