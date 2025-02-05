import 'dart:convert';
import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/modules/weather/weather.dart';

class WeatherService {
  static const url = "https://api.openweathermap.org/data/2.5/weather?q=";
  final String apiKey;

  WeatherService(this.apiKey);
  Future<Weather> getWeather(String cidade) async {
    final response =
        await http.get(Uri.parse('$url$cidade&appid=$apiKey&lang=pt'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar o clima');
    }
  }

  Future<String> getCurrentCidade() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: Platform.isAndroid
          ? AndroidSettings(accuracy: LocationAccuracy.high)
          : AppleSettings(accuracy: LocationAccuracy.high),
      // desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? cidade = placemark[0].subAdministrativeArea;

    return cidade ?? 'Não foi possível encontrar a cidade';
  }
}
