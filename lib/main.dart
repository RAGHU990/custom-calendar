// import 'package:flutter/material.dart';
// import 'package:calendar_view/calendar_view.dart';
// import 'package:intl/intl.dart'; // Import the intl package

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CalendarControllerProvider(
//       controller: EventController(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Calendar App',
//         theme: ThemeData(primarySwatch: Colors.purple),
//         home: CalendarPage(),
//       ),
//     );
//   }
// }




// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   late final EventController _eventController;
//   DateTime? _selectedDate;
//   DateTime _currentMonth = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     _eventController = EventController();
//     _addEvents();
//     print(_eventController.allEvents.first.event);
//   }


//   void _addEvents() {
//     _eventController.addAll([
//       CalendarEventData(
//         date: DateTime(2024, 8, 22),
//         color: Colors.blue,
//         event: const {"event_type": "Scheduled", "eventId": "APP001"},
//         title: "Mahindra Logistics",
//         description: "Logistics event",
//         startTime: DateTime(2024, 8, 22, 10, 0),
//         endTime: DateTime(2024, 8, 22, 12, 0),
//       ),
//       CalendarEventData(
//         date: DateTime(2024, 8, 22),
//         color: Colors.red,
//         event: const {"event_type": "Scheduled", "eventId": "APP001"},
//         title: "Mahindra Logistics",
//         description: "Logistics event",
//         startTime: DateTime(2024, 8, 22, 10, 0),
//         endTime: DateTime(2024, 8, 22, 12, 0),
//       ),
//       CalendarEventData(
//         date: DateTime(2024, 8, 23),
//         color: Colors.red,
//         event: const {"event_type": "Scheduled", "eventId": "APP001"},
//         title: "Mahindra Logistics",
//         description: "Logistics event",
//         startTime: DateTime(2024, 8, 23, 14, 0),
//         endTime: DateTime(2024, 8, 23, 15, 0),
//       ),
//       CalendarEventData(
//         date: DateTime(2024, 8, 23),
//         color: Colors.red,
//         event: const {"event_type": "Scheduled", "eventId": "APP001"},
//         title: "Mahindra Logistics",
//         description: "Logistics event",
//         startTime: DateTime(2024, 8, 24, 14, 0),
//         endTime: DateTime(2024, 8, 24, 15, 0),
//       ),
//       CalendarEventData(
//         date: DateTime(2024, 8, 23),
//         color: Colors.red,
//         event: const {"event_type": "Scheduled", "eventId": "APP001"},
//         title: "Mahindra Logistics",
//         description: "Logistics event",
//         startTime: DateTime(2024, 8, 24, 14, 0),
//         endTime: DateTime(2024, 8, 24, 15, 0),
//       ),
//     ]);
//   }

//   void _onMonthChanged(DateTime newMonth) {
//     setState(() {
//       _currentMonth = newMonth; // Update the current month
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Calendar'),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: Colors.grey)),
//                     height: 465,
//                     // color: Colors.white,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 16, right: 20, left: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 " ${DateFormat('MMMM').format(_currentMonth)} ${_currentMonth.year}",
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xff7c8388)),
//                               ),
//                               const Row(
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_today,
//                                     color: Colors.blue,
//                                   ),
//                                   SizedBox(width: 25),
//                                   Icon(
//                                     Icons.list,
//                                     size: 30,
//                                     // color: Colors.blue,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         const TabBar(
//                           labelColor: Colors.black,
//                           // indicatorColor: Color(0xff017abf),
//                           indicator: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Color(
//                                     0xff017abf), // Change this to your desired color
//                                 width: 4.0,
//                                 // Change this to your desired width
//                               ),
//                             ),
//                           ),
//                           tabs: [
//                             Tab(text: '          Month                    '),
//                             Tab(
//                                 text:
//                                     '             Week                             '),
//                             Tab(text: '            Day                       '),
//                           ],
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             children: [
//                               _buildMonthView(),
//                               _buildWeekView(),
//                               _buildDayView(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _eventList(_selectedDate ?? DateTime.now(),
//                 EventController()), // Pass the selected date
//           ],
//         ),
//       ),
//     );
//   }

//   // Update the current month when the month view changes

//   // Build Month View
//   Widget _buildMonthView() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         // border: Border.all(color: Colors.grey.withOpacity(0.5)),
//       ),
//       child: MonthView<Object?>(
//         headerBuilder: (DateTime date) => Container(),
//         controller: _eventController,
//         initialMonth: DateTime.now(),
//         minMonth: DateTime(2024, 1, 1),
//         maxMonth: DateTime(2024, 12, 31),
//         cellBuilder: (date, events, isToday, isInMonth, isSelected) {
//           bool isSelectedDate = _selectedDate != null &&
//               _selectedDate!.year == date.year &&
//               _selectedDate!.month == date.month &&
//               _selectedDate!.day == date.day;

//           Set<Color> eventColors = {};

//           // Collect colors from events
//           for (var event in events) {
//             eventColors.add(event.color); // Assuming `event.color` exists
//           }

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedDate = date;
//               });
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: isSelectedDate
//                       ? Colors.blue
//                       : Colors.grey.withOpacity(0.2),
//                   width: isSelectedDate ? 2 : 0.01,
//                 ),
//                 color: isSelectedDate
//                     ? Colors.transparent
//                     : isToday
//                         ? Colors.transparent
//                         : Colors.transparent,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (isToday)
//                       CircleAvatar(
//                         radius: 14,
//                         backgroundColor: Colors.blue,
//                         child: Text(
//                           '${date.day}',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     else
//                       Text(
//                         '${date.day}',
//                         style: TextStyle(
//                           fontWeight:
//                               isToday ? FontWeight.bold : FontWeight.bold,
//                           color: isInMonth ? Colors.black : Colors.grey,
//                           fontSize: 14,
//                         ),
//                       ),
//                     if (events.isNotEmpty) const SizedBox(height: 4),
//                     if (events.isNotEmpty)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: eventColors.map((color) {
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 2.0),
//                             child: CircleAvatar(
//                               radius: 3,
//                               backgroundColor: color,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         weekDayBuilder: (int index) {
//           return Column(
//             children: [
//               const SizedBox(height: 10),
//               Text(
//                 ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//               const SizedBox(height: 10),
//             ],
//           );
//         },
//         pageTransitionDuration: const Duration(milliseconds: 300),
//         pageTransitionCurve: Curves.ease,
//         startDay: WeekDays.sunday,
//         hideDaysNotInMonth: false,
//         pageViewPhysics: const BouncingScrollPhysics(),
//         cellAspectRatio: 0.9,
//         onPageChange: (DateTime date, int pageIndex) {
//           setState(() {
//             _onMonthChanged(date); // Update the current month
//           });
//         },
//       ),
//     );
//   }

//   // Build Day View
//   Widget _buildDayView() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DayView(
//         controller: _eventController,
//         showVerticalLine: true,
//         minDay: DateTime(2024, 1, 1),
//         maxDay: DateTime(2024, 12, 31),
//         initialDay: DateTime(2024, 8, 22),
//         timeLineBuilder: (hour) => Container(),
//         eventTileBuilder: (date, events, boundary, start, end) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               events.first.title,
//               style: const TextStyle(color: Colors.black),
//             ),
//           );
//         },
//         dayTitleBuilder: (date) => Container(),
//       ),
//     );
//   }

//   // Build Week View
//   Widget _buildWeekView() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         // border: Border.all(color: Colors.grey.withOpacity(0.5)),
//       ),
//       child: WeekView(
//         controller: _eventController,
//         showLiveTimeLineInAllDays: true,
//         minDay: DateTime(2024, 1, 1),
//         maxDay: DateTime(2024, 12, 31),
//         initialDay: DateTime(2024, 8, 22),
//         timeLineBuilder: (hour) => Container(),
//         eventTileBuilder: (date, events, boundary, start, end) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               events.first.title,
//               style: const TextStyle(color: Colors.black),
//             ),
//           );
//         },
//         weekPageHeaderBuilder: (startDate, endDate) => Container(),
//       ),
//     );
//   }

// Widget _eventList(DateTime selectedDate, EventController _eventController) {

//   // Filter events for the selected date
//   List<CalendarEventData> eventsForSelectedDate = _eventController.allEvents
//       .where((event) =>
//           event.date.year == selectedDate.year &&
//           event.date.month == selectedDate.month &&
//           event.date.day == selectedDate.day)
//       .toList();

       

//   return Column(
//     children: [
//       const SizedBox(height: 8),
//       const Divider(thickness: 4, color: Color.fromARGB(255, 218, 219, 219)),
//       const SizedBox(height: 2),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           color: Colors.transparent,
//           child: Row(
//             children: [
//               // Display the selected date
//               Container(
//                 color: Colors.transparent,
//                 height: 200,
//                 width: 50,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 8, top: 4, left: 0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('EEE')
//                             .format(selectedDate)
//                             .toUpperCase(), // Day of the week
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         '${selectedDate.day}', // Day of the month
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 200, // Set a fixed height for the ListView
//                       child: eventsForSelectedDate.isNotEmpty
//                           ? ListView.builder(
//                               itemCount: eventsForSelectedDate.length,
//                               itemBuilder: (context, index) {
//                                 final event = eventsForSelectedDate[index];
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(2),
//                                     border: Border.all(color: Colors.grey),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         spreadRadius: 0.5,
//                                         blurRadius: 0.5,
//                                         offset: const Offset(0, 1),
//                                       )
//                                     ],
//                                   ),
//                                   height: 70,
//                                   margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         color: event.color, // Use event color
//                                         height: 70,
//                                         width: 5,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Row(
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   event.title, // Event title from the event data
//                                                   style: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16),
//                                                 ),
//                                                 const SizedBox(height: 4),
//                                                 Text(
//                                                    "hello",
//                                                   // "${event.event?['event_type'] ?? 'N/A'} | ${event.event?['eventId'] ?? 'N/A'}", // Event details
//                                                   style: const TextStyle(
//                                                       color: Color.fromARGB(255, 100, 100, 100)),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(width: 90),
//                                             const Icon(
//                                               Icons.keyboard_arrow_right,
//                                               size: 30,
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             )
//                           : const Center(
//                               child: Text(
//                                 "No Events",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/calendar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: CalendarPage(),
    );
  }
}
