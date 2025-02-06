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
  final _weatherService = WeatherService('fe618f0a');
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
    if (getIsDay()) {
      switch (condicao.toLowerCase()) {
        case 'tempo nublado':
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
    } else {
      switch (condicao.toLowerCase()) {
        case 'tempo nublado':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/cloud.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/moon_cloud_rain.json';
        case 'thuderstorm':
          return 'assets/storm.json';
        case 'clear':
          return 'assets/moon.json';
        default:
          return 'assets/moon.json';
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getIsDay() ? Colors.white : const Color(0xFF10161E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_pin,
              color: getIsDay()
                  ? const Color(0xFF10161E)
                  : const Color(0xFFADACAC),
              size: 40,
            ),
            Text(
              (_weather?.cidade ?? 'Buscando Localização...').toUpperCase(),
              style: TextStyle(
                  color: getIsDay()
                      ? const Color(0xFF10161E)
                      : const Color(0xFFADACAC),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 100),
            Text(
              _weather?.condicao.toUpperCase() ?? '',
              style: TextStyle(
                color: getIsDay()
                    ? const Color(0xFF10161E)
                    : const Color(0xFFADACAC),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset(
              getWeatherAnimation(_weather?.condicao),
            ),
            Text(
              '${_weather?.temperatura ?? 0}°C',
              style: TextStyle(
                color: getIsDay()
                    ? const Color(0xFF10161E)
                    : const Color(0xFFADACAC),
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Temperatura Mínima:'.toUpperCase(),
                      style: TextStyle(
                        color: getIsDay()
                            ? const Color(0xFF10161E)
                            : const Color(0xFFADACAC),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.blue,
                        ),
                        Text(
                          '${_weather?.tempMin ?? 0}°C',
                          style: TextStyle(
                            color: getIsDay()
                                ? const Color(0xFF10161E)
                                : const Color(0xFFADACAC),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      'Temperatura Máxima:'.toUpperCase(),
                      style: TextStyle(
                        color: getIsDay()
                            ? const Color(0xFF10161E)
                            : const Color(0xFFADACAC),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_upward_outlined,
                          color: Colors.red,
                        ),
                        Text(
                          '${_weather?.tempMax ?? 0}°C',
                          style: TextStyle(
                            color: getIsDay()
                                ? const Color(0xFF10161E)
                                : const Color(0xFFADACAC),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
