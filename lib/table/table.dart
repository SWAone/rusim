// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// import 'Meeting.dart';
// import 'MeetingDataSource.dart';

// void main() {
//   return runApp(CalendarApp());
// }

// class CalendarApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
//   }
// }

// /// The hove page which hosts the calendar
// class MyHomePage extends StatefulWidget {
//   /// Creates the home page to display teh calendar widget.
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SfCalendar(
//       view: CalendarView.month,
//       dataSource: MeetingDataSource(MeetingDataSource.meetings),
//       // by default the month appointment display mode set as Indicator, we can
//       // change the display mode as appointment using the appointment display
//       // mode property
//       monthViewSettings: const MonthViewSettings(
//           appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
//     ));
//   }
// }
