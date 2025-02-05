import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/modules/services/weather_service.dart';
import 'package:weather/modules/weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('504301ddb9991ce29c0732fe5eb38cc9');
  Weather? _weather;

  _fetchWeather() async {
    String cidade = await _weatherService.getCurrentCidade();
    try {
      final weather = await _weatherService.getWeather(cidade);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  String getWeatherAnimation(String? condicao) {
    if (condicao == null) {
      return 'assets/load.json';
    }
    switch (condicao.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/sun_cloud_rain.json';
      case 'thuderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  bool getIsDay() {
    DateTime now = DateTime.now();
    final hour = now.hour;

    return hour >= 6 && hour < 18;
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  int calculaTemp(double temp) {
    return (temp - 273.15).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getIsDay() ? Colors.white : const Color(0xFF10161E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_pin),
            Text(
              _weather?.cidade ?? 'Carregando cidade...',
              style: TextStyle(
                  color: getIsDay() ? const Color(0xFF10161E) : Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100, top: 100),
              child: Lottie.asset(
                getWeatherAnimation(_weather?.condicao),
              ),
            ),
            Text(
              '${calculaTemp(_weather?.temperatura ?? 0)} °C',
              style: TextStyle(
                  color: getIsDay() ? const Color(0xFF10161E) : Colors.white),
            ),
            Text(
              _weather?.condicaoTraduzida ?? '',
              style: TextStyle(
                  color: getIsDay() ? const Color(0xFF10161E) : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
