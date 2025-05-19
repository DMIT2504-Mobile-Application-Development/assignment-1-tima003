class CurrentWeather {
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset;

  CurrentWeather({
    required String city,
    required String description,
    required double currentTemp,
    required DateTime currentTime,
    required DateTime sunrise,
    required DateTime sunset,
  }) {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;
    this.sunrise = sunrise;
    this.sunset = sunset;
  }

  String get city => _city;
  String get description => _description;
  double get currentTemp => _currentTemp;
  DateTime get currentTime => _currentTime;
  DateTime get sunrise => _sunrise;
  DateTime get sunset => _sunset;

  set city(String value) {
    if (value.trim().isEmpty) {
      throw Exception('City cannot be empty');
    }
    _city = value;
  }

  set description(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Description cannot be empty');
    }
    _description = value;
  }

  set currentTemp(double value) {
    if (value < -100 || value > 100) {
      throw Exception('Temperature must be between -100 and 100');
    }
    _currentTemp = value;
  }

  set currentTime(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }
    _currentTime = value;
  }

  set sunrise(DateTime value) {
    if (!_isSameDay(value, _currentTime)) {
      throw Exception('Sunrise must be on the same day as current time');
    }
    if (value.isAfter(_sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }
    _sunrise = value;
  }

  set sunset(DateTime value) {
    if (!_isSameDay(value, _currentTime)) {
      throw Exception('Sunset must be on the same day as current time');
    }
    if (value.isBefore(_sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }
    _sunset = value;
  }

  factory CurrentWeather.fromOpenWeatherData(dynamic data) {
    final city = data['name'];
    final description = data['weather'][0]['description'];
    final temp = (data['main']['temp'] as num).toDouble();
    final currentTime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000, isUtc: true);
    final sunrise = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000, isUtc: true);
    final sunset = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000, isUtc: true);

    return CurrentWeather(
      city: city,
      description: description,
      currentTemp: temp,
      currentTime: currentTime,
      sunrise: sunrise,
      sunset: sunset,
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  String toString() {
    return 'City: $_city, Description: $_description, Current Temperature: $_currentTemp, Current Time: $_currentTime, Sunrise: $_sunrise, Sunset: $_sunset';
  }
}
