import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

late DateTime currentDate;
late NeatCleanCalendarEvent currentEvent;

final List<NeatCleanCalendarEvent> eventList = [
  NeatCleanCalendarEvent('Ночь',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
      description: 'Атжумания',
      color: Colors.pink),
  NeatCleanCalendarEvent('День',
      startTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0),
      description: 'Бегат',
      color: Colors.pink),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Calendar(
            startOnMonday: true,
            weekDays: const ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'],
            eventsList: eventList,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            selectedTodayColor: Colors.red,
            onDateSelected: (value) => currentDate = value,
            todayColor: Color.fromARGB(255, 212, 41, 69),
            eventColor: const Color.fromARGB(255, 202, 17, 131),
            locale: 'ru_Ru',
            todayButtonText: 'Сегодня',
            allDayEventText: 'Весь день',
            multiDayEndText: 'Конец',
            isExpandable: true,
            isExpanded: true,
            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
            onEventSelected: (value) {},
            datePickerType: DatePickerType.date,
            dayOfWeekStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 11),
            eventTileHeight: 60,
            onEventLongPressed: (value) {
              currentEvent = value;
              Navigator.pushNamed(context, '/info');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          // ignore: unnecessary_null_comparison
          if (currentDate == null) return;
          Navigator.pushNamed(context, '/addEvent', arguments: <DateTime>{});
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }
}
