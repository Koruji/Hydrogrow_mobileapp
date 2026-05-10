import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class WeatherData {
  final double temperature;
  final int weatherCode;
  final String emoji;
  final String description;

  const WeatherData({
    required this.temperature,
    required this.weatherCode,
    required this.emoji,
    required this.description,
  });
}

class WeatherService {
  final Dio _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 8)));

  static String _codeToEmoji(int code) {
    if (code == 0) return '☀️';
    if (code <= 2) return '⛅';
    if (code == 3) return '☁️';
    if (code <= 48) return '🌫️';
    if (code <= 55) return '🌦️';
    if (code <= 67) return '🌧️';
    if (code <= 77) return '❄️';
    if (code <= 82) return '🌦️';
    if (code <= 86) return '🌨️';
    return '⛈️';
  }

  static String _codeToDescription(int code) {
    if (code == 0) return 'Ensoleillé';
    if (code <= 2) return 'Nuageux';
    if (code == 3) return 'Couvert';
    if (code <= 48) return 'Brouillard';
    if (code <= 55) return 'Bruine';
    if (code <= 67) return 'Pluie';
    if (code <= 77) return 'Neige';
    if (code <= 82) return 'Averses';
    if (code <= 86) return 'Neige';
    return 'Orage';
  }

  static WeatherData get _mock => const WeatherData(
        temperature: 22,
        weatherCode: 1,
        emoji: '⛅',
        description: 'Nuageux',
      );

  Future<WeatherData?> fetch() async {
    if (kIsWeb) return _mock;

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      ).timeout(const Duration(seconds: 10));

      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': position.latitude.toStringAsFixed(4),
          'longitude': position.longitude.toStringAsFixed(4),
          'current': 'temperature_2m,weather_code',
          'timezone': 'auto',
        },
      );

      final current = response.data['current'] as Map<String, dynamic>;
      final temperature = (current['temperature_2m'] as num).toDouble();
      final weatherCode = (current['weather_code'] as num).toInt();

      return WeatherData(
        temperature: temperature,
        weatherCode: weatherCode,
        emoji: _codeToEmoji(weatherCode),
        description: _codeToDescription(weatherCode),
      );
    } catch (_) {
      return null;
    }
  }
}
