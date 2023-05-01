// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:weather_manager/Entity/WeatherEntity.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class daysFinds {
  List<String> chose_day = [];
  List<String> other_day = [];
  DateTime day = DateTime.now();

  daysFinds(List<String> choose_day, other_day, DateTime day) {
    this.chose_day = choose_day;
    this.other_day = other_day;
    this.day = day;
  }
}

// ignore: camel_case_types
class fetchDays {
  final String _token = "13fe948b-599e-4242-a0d8-b4e08993b74f";
  //final String url_base = 'lat=51.660779&lon=39.200292';
  final String head = 'X-Yandex-API-Key';

  Future<WeatherEntity?> fetchEvent(String url_base) async {
    final response = await http.get(
        Uri.parse(
            'https://api.weather.yandex.ru/v2/forecast?$url_base&extra=false}'),
        headers: {head: _token});

    if (response.statusCode == 200) {
      var responseMap = await jsonDecode(response.body);

      Map<String, dynamic> temp = responseMap;

      WeatherEntity entity = WeatherEntity.fromJson(temp);

      return entity;
    }
    return WeatherEntity();
  }

  Future<daysFinds> searchDay(String type, String weather, String cloud,
      int temperature, DateTime date,String url_base) async {
    final entity = await fetchEvent(url_base);

    List<String> good_day = [];
    List<String> choose_day = [];

    if (date.hour <= 22 && date.hour >= 5) {
      entity!.forecasts!.forEach((element) {
        var item = element.parts!.nightShort;

        if (item!.cloudness!.toDouble() <= double.parse(cloud) &&
            (item.temp!.toInt() <= temperature + 5 &&
                item.temp!.toInt() >= temperature - 1) &&
            item.precType!.toDouble() <= double.parse(weather)) {
          good_day.add(element.date!);
        }
      });
    } else {
      entity!.forecasts!.forEach((element) {
        var item = element.parts!.dayShort;
        if (item!.cloudness!.toDouble() <= double.parse(cloud) &&
            (item.temp!.toInt() <= temperature + 5 &&
                item.temp!.toInt() >= temperature - 1) &&
            item.precType!.toDouble() <= double.parse(weather)) {
          good_day.add(element.date!);
        }
      });
    }

    good_day.forEach((element) {
      if (DateTime.parse(element).day == date.day) {
        choose_day.add(element);
      }
    });

    return daysFinds(choose_day, good_day, date);
  }
}
