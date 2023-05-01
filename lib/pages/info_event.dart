import 'package:flutter/material.dart';
import 'package:weather_manager/pages/home.dart';

class ShowInfo extends StatefulWidget {
  const ShowInfo({super.key});

  @override
  State<ShowInfo> createState() => _ShowInfo();
}

class _ShowInfo extends State<ShowInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Информация'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 67,
              child: TextFormField(
                initialValue: currentEvent.description,
                style: const TextStyle(fontSize: 19, color: Colors.black),
                readOnly: true,
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Название',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 67,
              child: TextFormField(
                initialValue: currentEvent.location,
                style: const TextStyle(fontSize: 19, color: Colors.black),
                readOnly: true,
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Город',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 67,
              child: TextFormField(
                initialValue:
                    '${currentEvent.startTime.day}-${currentEvent.startTime.month}-${currentEvent.startTime.year}',
                style: const TextStyle(fontSize: 19, color: Colors.black),
                readOnly: true,
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Дата',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 67,
              child: TextFormField(
                initialValue:
                    '${currentEvent.startTime.hour}-${replaceNul(currentEvent.startTime.minute)}',
                style: const TextStyle(fontSize: 19, color: Colors.black),
                readOnly: true,
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Начало',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 67,
              child: TextFormField(
                initialValue:
                    '${currentEvent.endTime.hour}-${replaceNul(currentEvent.endTime.minute)}',
                style: const TextStyle(fontSize: 19, color: Colors.black),
                readOnly: true,
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Конец',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String replaceNul(int value){
    if (value == 0) return '00';
    else return value.toString();
  }

}
