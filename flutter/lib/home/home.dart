import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:firebase_playground/logger.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_playground/dataconnect-generated/dart/default_connector/default.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: CalendarDataFetcher(),
    );
  }
}

class CalendarDataFetcher extends StatelessWidget {
  const CalendarDataFetcher({super.key});

  @override
  Widget build(BuildContext context) {
    var future = DefaultConnector.instance.getEvents().execute();
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CalendarPartial(
            dataSource: AppointmentDataSource.from(snapshot.data!.data.events),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class CalendarPartial extends StatelessWidget {
  AppointmentDataSource dataSource;

  CalendarPartial({super.key, required this.dataSource});

  void _onTap(CalendarTapDetails tapDetails, BuildContext context) {
    var tappedAppointemnts = tapDetails.appointments;

    if (tappedAppointemnts != null && tappedAppointemnts.isNotEmpty) {
      _showBottomSheet(
        AppointmentViewPartial(appointment: tappedAppointemnts.first),
        context,
      );
      return;
    }
  }

  void _longPress(CalendarLongPressDetails pressDetails) {
    var pressedAppointments = pressDetails.appointments;
    var pressedDate = pressDetails.date;

    if (pressedAppointments != null && pressedAppointments.isNotEmpty) {
      return;
    }

    if (pressedDate != null) {
      _createNewAppointment(pressedDate);
    }
  }

  void _createNewAppointment(DateTime start) {
    var newAppointment = Appointment(
      subject: "New Appointment",
      startTime: start.toLocal(),
      endTime: start.toLocal().add(Duration(hours: 1)),
    );

    dataSource.appointments!.add(newAppointment);
    dataSource.notifyListeners(CalendarDataSourceAction.add, [newAppointment]);

    var timestamp = Timestamp(
      0,
      newAppointment.startTime.millisecondsSinceEpoch ~/ 1000,
    );

    LoggerFactory.instance.d("Start ${newAppointment.startTime.toString()}");
    LoggerFactory.instance.d("Timestamp ${timestamp.toJson()}");

    DefaultConnector.instance
        .createEvent(
          subject: newAppointment.subject,
          startTime: timestamp,
          // startTime: Timestamp(
          //   0,
          //   newAppointment.startTime.millisecondsSinceEpoch ~/ 1000,
          // ),
          endTime: Timestamp(
            0,
            newAppointment.endTime.millisecondsSinceEpoch ~/ 1000,
          ),
        )
        .execute()
        .catchError((e) {
          LoggerFactory.instance.e("Failed to save event ${e.toString()}");
        });
  }

  void _showBottomSheet(Widget child, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            child,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      showNavigationArrow: true,
      showTodayButton: true,
      showDatePickerButton: true,
      allowViewNavigation: true,
      timeZone: "America/Los_Angeles",
      allowedViews: [
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month,
      ],
      onTap: (details) => _onTap(details, context),
      onLongPress: _longPress,
      dataSource: dataSource,
    );
  }
}

class AppointmentViewPartial extends StatelessWidget {
  final Appointment appointment;
  const AppointmentViewPartial({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(appointment.subject),
        Text(appointment.startTime.toString()),
        Text(appointment.endTime.toString()),
      ],
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> events) {
    appointments = events;
    LoggerFactory.instance.d("Data bound with ${events.length} events.");
    if (events.isNotEmpty) {
      LoggerFactory.instance.d(
        "First start time ${events.first.startTime.toString()}.",
      );
    }
  }

  static AppointmentDataSource from(List<GetEventsEvents> input) {
    var mappedEvents = input.map(
      (event) => Appointment(
        startTime: event.startTime.toDateTime().toUtc(),
        endTime: event.endTime.toDateTime().toUtc(),
        subject: event.subject,
        location: event.location,
        recurrenceRule: event.recurrenceRule,
      ),
    );

    return AppointmentDataSource(mappedEvents.toList());
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.now();
    // return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.now().add(Duration(hours: 1));
    // return appointments![index].endTime;
  }

  @override
  bool isAllDay(int index) {
    return false;
    // return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  // @override
  // String getStartTimeZone(int index) {
  //   // return appointments![index].startTimeZone;
  //   return "America/Los_Angeles";
  // }
  //
  // @override
  // String getEndTimeZone(int index) {
  //   // return appointments![index].endTimeZone;
  //   return "America/Los_Angeles";
  // }

  @override
  Color getColor(int index) {
    // return appointments![index].background;
    return Colors.blueGrey;
  }
}

// class AppointmentDataSource extends CalendarDataSource {
//   AppointmentDataSource(List<GetEventsEvents> events) {
//     appointments = events;
//     LoggerFactory.instance.d("Data bound with ${events.length} events.");
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].startTime.toDateTime();
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].endTime.toDateTime();
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return false;
//     // return appointments![index].isAllDay;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments![index].subject;
//   }
//
//   @override
//   String getStartTimeZone(int index) {
//     // return appointments![index].startTimeZone;
//     return "America/Los_Angeles";
//   }
//
//   @override
//   String getEndTimeZone(int index) {
//     // return appointments![index].endTimeZone;
//     return "America/Los_Angeles";
//   }
//
//   @override
//   Color getColor(int index) {
//     // return appointments![index].background;
//     return Colors.blueGrey;
//   }
// }
