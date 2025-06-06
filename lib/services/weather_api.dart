import 'dart:convert';
import 'package:http/http.dart' as http;

const String weatherApiKey = 'ea9bd6165b5f64d61c39bb2f97314869';
const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({required String city}) async {
  final url = '$currentWeatherEndpoint?units=metric&q=$city&appid=$weatherApiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('There was a problem with the request: status ${response.statusCode} received');
    }

    return jsonDecode(response.body);
  } catch (e) {
    throw Exception('There was a problem with the request: $e');
  }
}
