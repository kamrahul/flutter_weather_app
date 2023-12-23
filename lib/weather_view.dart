import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/service/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key

  final _weatherService = WeatherService("b66ab3b2f584e57701a2d270aaae97d4");
  Weather? _weather;
  // Fetch weather
  _featchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // Get current city weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunnny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';

      case 'mist':
        return 'assets/fog.json';
      case 'smoke':
        return 'assets/fog.json';
      case 'haze':
        return 'assets/fog.json';
      case 'dust':
        return 'assets/fog.json';
      case 'fog':
        return 'assets/fog.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
    }
    return 'assets/sunny.json';
  }

// init state implemneation when app starts up
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fetch the weather
    _featchWeather();
  }

// weather animations

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City name
              Text(
                _weather?.cityName ?? "Loading.. ",
                style: const TextStyle(color: Colors.blue, fontSize: 20),
              ),

              // animation

              Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? "")),

              // Temperature
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${_weather?.temperature.round()}°',
                      style: const TextStyle(color: Colors.blue, fontSize: 80)),
                  Text("C",
                      style: const TextStyle(color: Colors.blue, fontSize: 40)),
                ],
              ),

              Text(
                _weather?.mainCondition ?? "",
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
