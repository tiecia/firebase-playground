import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: CalendarPartial(),
    );
  }
}

class CalendarPartial extends StatefulWidget {
  const CalendarPartial({super.key});

  @override
  State<CalendarPartial> createState() => _CalendarPartialState();
}

class _CalendarPartialState extends State<CalendarPartial> {
  void _onTap(CalendarTapDetails tapDetails) {
    var tappedAppointemnts = tapDetails.appointments;
    var tappedDate = tapDetails.date;

    if (tappedAppointemnts != null && tappedAppointemnts.isNotEmpty) {
      _showBottomSheet(
        AppointmentViewPartial(appointment: tappedAppointemnts.first),
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
      startTime: start,
      endTime: start.add(Duration(hours: 1)),
    );

    _dataSource.appointments!.add(newAppointment);
    _dataSource.notifyListeners(CalendarDataSourceAction.add, [newAppointment]);
  }

  void _showBottomSheet(Widget child) {
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

  final AppointmentDataSource _dataSource = AppointmentDataSource();

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      showNavigationArrow: true,
      showTodayButton: true,
      showDatePickerButton: true,
      allowViewNavigation: true,
      allowedViews: [
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month,
      ],
      onTap: _onTap,
      onLongPress: _longPress,
      dataSource: _dataSource,
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
  AppointmentDataSource() {
    appointments = [
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
        subject: "New appointment",
      ),
    ];
  }
}
