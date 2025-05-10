import 'package:test/test.dart';
import 'package:assignment_01/services/weather_api.dart';

void main() {
  group('Weather API', () {
    test('weatherApiKey exists', () {
      expect(weatherApiKey, isA<String>());
    });

    test('currentWeatherEndpoint exists', () {
      expect(currentWeatherEndpoint, isA<String>());
    });

    // Ideally, we would set up our code so that the call to the network
    // can be mocked/faked. Difficult in this situation, and this way actually
    // tests the calls for the student too.
    test('getWeatherForCity returns the weather information', () async {
      const city = 'Edmonton';
      const country = 'CA';
      final weatherData = await getWeatherForCity(city: '$city,$country');

      expect(weatherData['weather'], isA<List<dynamic>>());
      expect(weatherData['name'], equals(city));
    });

    test(
        'getWeatherForCity throws an exception when request fails or not status 200',
        () async {
      expect(
        () async => await getWeatherForCity(city: 'nosuchplace'),
        throwsA(
          isA<Exception>().having(
            (exception) => exception.toString(),
            'message',
            contains(
                'There was a problem with the request: '), // The error message.
          ),
        ),
      );
    });
  });
}
