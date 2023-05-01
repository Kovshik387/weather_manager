// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'home.dart';
import 'package:weather_manager/service/check_days.dart';

const List<String> themeEvent = ['holiday', 'Rest', 'Event']; // хуйня
const List<String> precType = ['0', '1', '2', '3', '4']; // тип осадков

const List<String> cloudness = ['0', '0.25', '0.5', '0.75', '1']; // солнце

final confirmDate = DateTime.utc(
  currentDate.year,
  currentDate.month,
  currentDate.day,
  time.hour,
  time.minute,
);

Map<String, String> city = {
  'lat=55.81579208&lon=37.38003159': 'moscow',
  'lat=51.660779&lon=39.200292': 'voronezh',
  'lat=59.93909836&lon=30.31587601': 'saintPetersburg',
  'lat=48.7070694&lon=44.51697922': 'volgograd',
  'lat=50.79450989&lon=41.99559021': 'uryupinsk',
  'lat=52.60882568&lon=39.59922791': 'lipetsk',
  'lat=49.80775833&lon=73.08850861': 'karaganda'
};

String _dropdownTypeValue = "";
String _dropdownPrecValue = "";
String _dropdownCloudValue = "";
String _dropdownCityValue = "";
String nameEvent = "untiled";
int temperature = 0;
int newTime = 1;
DateTime? addDate;

TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);

class AddEvent extends StatefulWidget {
  const AddEvent({super.key, required this.currentDate});

  final DateTime currentDate;

  @override
  State<AddEvent> createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Создание мероприятия'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Название"),
              onFieldSubmitted: (value) => nameEvent = value,
              onChanged: (value) => nameEvent = value,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: DropdownButton(
                items: dropDownEvent(),
                value: _dropdownTypeValue,
                onChanged: dropdownCallback,
                isExpanded: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: DropdownButton(
                items: dropDownPrecEvent(),
                value: _dropdownPrecValue,
                onChanged: dropdownPrecCallback,
                isExpanded: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: DropdownButton(
                items: _dropdownCloudEvent(),
                value: _dropdownCloudValue,
                onChanged: dropdownCloudCallback,
                isExpanded: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: DropdownButton(
                items: _dropdownCityEvent(),
                value: _dropdownCityValue,
                onChanged: dropdownCityCallback,
                isExpanded: true,
              ),
            ),
            const Spacer(
              flex: 15,
            ),
            SpinBox(
              value: 0,
              min: -40,
              max: 40,
              readOnly: true,
              onChanged: (value) => temperature = value.toInt(),
              decoration: const InputDecoration(labelText: 'Температура'),
            ),
            const Spacer(
              flex: 15,
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('${time.hour}:${time.minute}',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 26)),
                ),
                const Spacer(
                  flex: 40,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.pink),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          useRootNavigator: false,
                          context: context,
                          initialTime: time,
                          builder: (context, child) =>
                              use24hours(context, child!),
                        );
                        if (newTime == null) {
                          return;
                        } else {
                          setState(() => time = newTime);
                        }
                      },
                      child: const Text(
                        'Выбрать время',
                        style: TextStyle(fontSize: 16),
                      )),
                )
              ],
            ),
            const Spacer(flex: 40),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.pink),
                          ),
                        ),
                      ),
                      onPressed: () {
                        printInfo();
                      },
                      child: const Text(
                        'Добавить мероприятие',
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  MediaQuery use24hours(BuildContext context, Widget child) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child);
  }

  List<DropdownMenuItem<String>> dropDownEvent() {
    return [
      const DropdownMenuItem<String>(
        value: "holiday",
        child: Text("Праздник"),
      ),
      const DropdownMenuItem<String>(
        value: "Rest",
        child: Text("Отдых"),
      ),
      const DropdownMenuItem<String>(
        value: "Event",
        child: Text("Мероприятие"),
      ),
    ];
  }

  List<DropdownMenuItem<String>> dropDownPrecEvent() {
    return [
      const DropdownMenuItem<String>(
        value: "0",
        child: Text("Нет осадков"),
      ),
      const DropdownMenuItem<String>(
        value: "1",
        child: Text("Дождь"),
      ),
      const DropdownMenuItem<String>(
        value: "2",
        child: Text("Дождь со снегом"),
      ),
      const DropdownMenuItem<String>(
        value: "3",
        child: Text("Снег"),
      ),
      const DropdownMenuItem<String>(
        value: "4",
        child: Text("Град"),
      ),
    ];
  }

  List<DropdownMenuItem<String>> _dropdownCloudEvent() {
    return [
      const DropdownMenuItem<String>(
        value: "0",
        child: Text("Солнечно"),
      ),
      const DropdownMenuItem<String>(
        value: "0.25",
        child: Text("Малооблачно"),
      ),
      const DropdownMenuItem<String>(
        value: "0.5",
        child: Text("облачно"),
      ),
      const DropdownMenuItem<String>(
        value: "1",
        child: Text("Пасмурно"),
      )
    ];
  }

  List<DropdownMenuItem<String>> _dropdownCityEvent() {
    return [
      const DropdownMenuItem<String>(
        value: "lat=55.81579208&lon=37.38003159",
        child: Text("Москва"),
      ),
      const DropdownMenuItem<String>(
        value: "lat=51.660779&lon=39.200292",
        child: Text("Воронеж"),
      ),
      const DropdownMenuItem<String>(
        value: "lat=59.93909836&lon=30.31587601",
        child: Text("Санкт-Петербург"),
      ),
      const DropdownMenuItem<String>(
        value: "lat=48.7070694&lon=44.51697922",
        child: Text("Волгоград"),
      ),
      const DropdownMenuItem<String>(
        value: "lat=50.79450989&lon=41.99559021",
        child: Text("Урюпинск"),
      ),
      const DropdownMenuItem<String>(
        value: "lat=52.60882568&lon=39.59922791",
        child: Text("Липецк"),
      ),
      const DropdownMenuItem<String>(
        value: "lat=49.80775833&lon=73.08850861",
        child: Text("Караганда"),
      )
    ];
  }

  void dropdownPrecCallback(String? selectedValue) {
    if (selectedValue is String) {
      (setState(() => _dropdownPrecValue = selectedValue));
    }
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      (setState(() => _dropdownTypeValue = selectedValue));
    }
  }

  void dropdownCloudCallback(String? selectedValue) {
    if (selectedValue is String) {
      (setState(() => _dropdownCloudValue = selectedValue));
    }
  }

  void dropdownCityCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(
        () => _dropdownCityValue = selectedValue,
      );
    }
  }

  @override
  void initState() {
    _dropdownTypeValue = themeEvent.first;
    _dropdownCloudValue = cloudness.first;
    _dropdownPrecValue = precType.first;
    _dropdownCityValue = city.entries.first.key;
    super.initState();
  }

  Future<void> printInfo() async {
    print("|--------------------------------------|");
    print('тип праздника: $_dropdownTypeValue');
    print('погода: $_dropdownPrecValue');
    print('осадки: $_dropdownCloudValue');
    print('температура: $temperature');
    print('название: $nameEvent');
    print('Поиск по: $confirmDate');
    print('Город: ${city[_dropdownCityValue]}');
    print("|--------------------------------------|");
    final fetch = fetchDays();
    final result = (await fetch.searchDay(
        _dropdownTypeValue,
        _dropdownPrecValue,
        _dropdownCloudValue,
        temperature,
        currentDate,
        _dropdownCityValue));

    if (result.chose_day.isEmpty) {
      if (result.other_day.isEmpty) {
        print('Подходящий день не найден');
        showNonDays();
      } else {
        print('Предлогаемые даты: ${result.other_day}');
        showManydays(result.other_day);
      }
    } else {
      print('День удовлетворяет условиям: ${result.chose_day[0]}');
      showDay();
    }
  }

  Future<dynamic> showNonDays() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Подходящий день не найден',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Закрыть'),
                ),
              ]),
        ),
      ),
    );
  }

  Future<dynamic> showDay() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinBox(
                  direction: Axis.horizontal,
                  value: 1,
                  min: 1,
                  max: 24,
                  onChanged: (value) => newTime = value.toInt(),
                  decoration: const InputDecoration(
                      labelText: 'Длительность',
                      hintStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  enableInteractiveSelection: false,
                  readOnly: true,
                  iconSize: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Закрыть'),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      TextButton(
                        onPressed: () {
                          print('Cформированная: $confirmDate');

                          final item = NeatCleanCalendarEvent(nameEvent,
                              startTime: confirmDate,
                              endTime:
                                  confirmDate.add(Duration(hours: newTime)),
                              location: city[_dropdownCityValue]!,
                              color: Colors.pink);

                          eventList.add(item);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/authorize', (route) => false);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Colors.pink),
                            ),
                          ),
                        ),
                        child: const Text('Добавить',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Future<dynamic> showManydays(List<String> list) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Выбор даты',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => SizedBox(
                      height: 150,
                      child: TextButton(
                          onPressed: () {
                            print(list[index]);
                            addDate = DateTime.tryParse(list[index]);
                            print(addDate);
                          },
                          child: Text(
                            list[index],
                            style: const TextStyle(fontSize: 30),
                          ))),
                  itemCount: list.length,
                ),
              ),
              const Spacer(flex: 25),
              SizedBox(
                height: 50,
                width: 120,
                child: SpinBox(
                  direction: Axis.horizontal,
                  value: 1,
                  min: 1,
                  max: 24,
                  onChanged: (value) => newTime = value.toInt(),
                  decoration: const InputDecoration(labelText: 'Длительность'),
                  enableInteractiveSelection: false,
                  readOnly: true,
                  iconSize: 10,
                ),
              ),
              const Spacer(flex: 160),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Закрыть'),
                    ),
                    const Spacer(flex: 40),
                    TextButton(
                      onPressed: () {
                        addDate!.add(Duration(
                            hours: confirmDate.hour,
                            minutes: confirmDate.minute));
                        final dateGo = DateTime(addDate!.year, addDate!.month,
                            addDate!.day, confirmDate.hour, confirmDate.minute);

                        print(
                            'Сформированная дата: $dateGo\nНе сформированная: $confirmDate');

                        final item = NeatCleanCalendarEvent(nameEvent,
                            startTime: dateGo,
                            endTime: dateGo.add(Duration(hours: newTime)),
                            location: city[_dropdownCityValue]!,
                            color: Colors.pink);

                        eventList.add(item);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/authorize', (route) => false);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.pink),
                          ),
                        ),
                      ),
                      child: const Text('Добавить',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
