import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ScheduledItem> items = [
      ScheduledItem(
        from: DateTime.now(),
        startTimeZone: "America/Los_Angeles",
        to: DateTime.now().add(Duration(hours: 1)),
        endTimeZone: "America/Los_Angeles",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SfCalendar(
        showNavigationArrow: true,
        showTodayButton: true,
        showDatePickerButton: true,
        dataSource: MeetingDataSource(items),
      ),
    );
  }
}

class ScheduledItem {
  ScheduledItem({
    required this.from,
    required this.startTimeZone,
    required this.to,
    required this.endTimeZone,
    this.eventName = "New Item",
    this.background = Colors.blue,
  });

  String eventName;
  DateTime from;
  String startTimeZone;
  DateTime to;
  String endTimeZone;
  bool isAllDay = false;
  Color background;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<ScheduledItem> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return appointments![index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return appointments![index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}
