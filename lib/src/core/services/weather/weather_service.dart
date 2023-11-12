import 'package:geolocator/geolocator.dart';
import 'package:tech_goal/src/core/url/app_urls.dart';
import 'package:dio/dio.dart';

class Location {
  late double latitude;
  late double longitude;
  late int status;


  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}


class NetworkData {
  final Dio dio = Dio();
  final String url;

  NetworkData(this.url);

  Future getData() async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}



class WeatherModel {
  Dio dio = Dio();

  Future<dynamic> getCityWeather(String cityName) async {
    try {
      final response = await dio.get(
        '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric',
      );
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    try {
      final response = await dio.get(
        '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
      );
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

}



