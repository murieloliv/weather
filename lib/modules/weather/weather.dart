class Weather {
  final String cidade;
  final int temperatura;
  final String condicao;
  final int tempMin;
  final int tempMax;

  Weather({
    required this.cidade,
    required this.temperatura,
    required this.condicao,
    required this.tempMin,
    required this.tempMax,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    var results = json['results'];
    var forecastList = results['forecast'];

    return Weather(
      cidade: results['city'] ?? 'Cidade Indisponível',
      temperatura: results['temp'] ?? 0.0,
      condicao: results['description'] ?? 'Condição Indisponível',
      tempMin: forecastList[0]['min'],
      tempMax: forecastList[0]['max'],
      // tempMax: json['main']['temp_max'].toDouble(),
    );
  }
}
