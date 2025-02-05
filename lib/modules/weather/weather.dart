class Weather {
  final String cidade;
  final int temperatura;
  final String condicao;
  final double tempMin;
  final double tempMax;

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

    double tempMin =
        forecastList.isNotEmpty ? forecastList[0]['min'].toDouble() : 0.0;
    double tempMax =
        forecastList.isNotEmpty ? forecastList[0]['max'].toDouble() : 0.0;
    return Weather(
      cidade: results['city'] ?? 'Cidade Indisponível',
      temperatura: results['temp'] ?? 0.0,
      condicao: results['description'] ?? 'Condição Indisponível',
      tempMin: tempMin,
      tempMax: tempMax,
      // tempMax: json['main']['temp_max'].toDouble(),
    );
  }
}
