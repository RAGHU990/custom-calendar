// views/calendar_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart';
import '../../utils/assets/asset.dart';
import '../controllers/calendar_controller.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
  return ScreenUtilInit(
    designSize: const Size(360, 690), // Define your design size
    builder: (context, child) {
      return DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _addressContainer(),
                Padding(
                  padding: EdgeInsets.all(16.sp), // Responsive padding
                  child: Column(
                    children: [
                      _appointmentsButton(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        height: 375.h, // Responsive height
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 16.sp,
                                right: 20.sp,
                                left: 16.sp,
                              ),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " ${DateFormat('MMMM').format(controller.currentMonth.value)} ${controller.currentMonth.value.year}",
                                      style: TextStyle(
                                        fontSize: 18.sp, // Responsive font size
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff7c8388),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(width: 25),
                                        Icon(
                                          Icons.list,
                                          size: 30, // Keep icon size fixed
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const TabBar(
                              labelColor: Colors.black,
                              indicator: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff017abf),
                                    width: 4.0,
                                  ),
                                ),
                              ),
                              tabs: [
                                Tab(
                                  text: '          Month                                       ',
                                ),
                                Tab(
                                  text: '             Week                                           ',
                                ),
                                Tab(
                                  text: '           Day                                                  ',
                                ),
                              ],
                            ),
                            Expanded(
                              child: Obx(
                                () => TabBarView(
                                  children: [
                                    _buildMonthView(controller),
                                    _buildWeekView(controller, context),
                                    _buildDayView(controller),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => _eventList(controller)),
              ],
            ),
          ),
        ),
      );
    },
  );
}
 PreferredSizeWidget _appBar() {
  return AppBar(
    title: Text(
      'Appointments',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.sp, // Make font size responsive
      ),
    ),
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.all(8.sp), // Make padding responsive
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(6.h), // Make height responsive
      child: SizedBox(
        height: 6.h, // Make height responsive
        child: SvgPicture.asset(
          Assets.superGraphic,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
 
 Widget _addressContainer() {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: Colors.black)),
    ),
    child: Padding(
      padding: EdgeInsets.all(16.sp), // Responsive padding
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 20.sp, color: Colors.blue), // Responsive icon size
              SizedBox(width: 5.w), // Responsive spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "BidP",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, size: 20.sp), // Responsive icon size
                    ],
                  ),
                  Text(
                    "84, Hosur Rd, Madiwala, Bengaluru, Karnataka 560068",
                    style: TextStyle(
                      fontSize: 12.sp, // Responsive font size
                      color: Colors.black54, // Optional: Slightly lighter color for the address
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _appointmentsButton() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 4, // Keep this fixed or use .sp for responsiveness
                    backgroundColor: Colors.blue,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.sp), // Responsive padding
                    child: Text(
                      "Loading",
                      style: TextStyle(fontSize: 12.sp), // Responsive font size
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp), // Responsive padding
                child: Container(
                  width: 2.w, // Responsive width
                  height: 20.h, // Responsive height
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 4, // Keep this fixed or use .sp for responsiveness
                    backgroundColor: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.sp), // Responsive padding
                    child: Text(
                      "Unloading",
                      style: TextStyle(fontSize: 12.sp), // Responsive font size
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.sp), // Responsive padding
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF017abf),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.sp), // Responsive border radius
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [ 
                  const Icon(Icons.add, color: Colors.white),
                // Responsive spacing
                  Text(
                    "Appointment",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp), // Responsive font size
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
Widget _buildMonthView(CalendarController controller) {
  return Obx(
    () => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp), // Responsive border radius
      ),
      child: MonthView<Object?>(
        headerBuilder: (DateTime date) => Container(),
        controller: controller.eventController.value,
        initialMonth: DateTime.now(),
        minMonth: DateTime(1900),
        maxMonth: DateTime(2100),
        cellBuilder: (date, events, isToday, isInMonth, isSelected) {
          bool isSelectedDate =
              controller.selectedDate.value.year == date.year &&
                  controller.selectedDate.value.month == date.month &&
                  controller.selectedDate.value.day == date.day;

          final List<CalendarEventData> eventsForDate = controller.allEvents
              .where((event) =>
                  event.date.year == date.year &&
                  event.date.month == date.month &&
                  event.date.day == date.day)
              .toList();

          Set<Color> eventColors = {};
          for (var event in eventsForDate) {
            eventColors.add(event.color);
          }

          return GestureDetector(
            onTap: () {
              controller.setSelectedDate(date);
              controller.selectedEvent.clear();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelectedDate
                      ? Colors.grey
                      : Colors.grey.withOpacity(0.2),
                  width: isSelectedDate ? 2.sp : 0.01.sp, // Responsive width
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(6.sp), // Responsive padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isToday)
                      CircleAvatar(
                        radius: 14.sp, // Responsive radius
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp, // Responsive font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isInMonth ? Colors.black : Colors.grey,
                          fontSize: 12.sp, // Responsive font size
                        ),
                      ),
                    if (eventsForDate.isNotEmpty) SizedBox(height: 4.sp), // Responsive spacing
                    if (eventsForDate.isNotEmpty && eventColors.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: eventColors.map((color) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.sp), // Responsive padding
                            child: CircleAvatar(
                              radius: 3.sp, // Responsive radius
                              backgroundColor: color,
                            ),
                          );
                        }).toList(),
                      )
                  ],
                ),
              ),
            ),
          );
        },
        weekDayBuilder: (int index) {
          return Column(
            children: [
              SizedBox(height: 10.sp), // Responsive spacing
              Text(
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12.sp, // Responsive font size
                ),
              ),
              SizedBox(height: 10.sp), // Responsive spacing
            ],
          );
        },
        pageTransitionDuration: const Duration(milliseconds: 300),
        pageTransitionCurve: Curves.ease,
        startDay: WeekDays.sunday,
        hideDaysNotInMonth: false,
        pageViewPhysics: const BouncingScrollPhysics(),
        cellAspectRatio: 0.9,
        onPageChange: (DateTime date, int pageIndex) {
          controller.onMonthChanged(date);
        },
      ),
    ),
  );
}
 
 
Widget _buildWeekView(CalendarController controller, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.sp), // Responsive border radius
    ),
    child: WeekView<Object?>(
      controller: controller.eventController.value, // Use the observable event controller
      onPageChange: (DateTime date, int pageIndex) {
        controller.onMonthChanged(date);
      },
      showLiveTimeLineInAllDays: true,
      minDay: DateTime(2024, 1, 1),
      maxDay: DateTime(2024, 12, 31),
      initialDay: controller.selectedDate.value, // Use the selected date from the controller
      timeLineBuilder: (total) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp), // Responsive padding
          child: Text(
            '${total.hour.toString().padLeft(2, '0')}:00',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10.sp, // Responsive font size
            ),
          ),
        );
      },
      eventTileBuilder: (date, events, boundary, start, end) {
        // Check if the date is today
        bool isToday = date.isAtSameMomentAs(DateTime.now());

        return Container(
          color: const Color.fromARGB(255, 226, 226, 224),
          child: Row(
            children: [
              if (isToday) ...[
                const CircleAvatar(
                  backgroundColor: Colors.blue, // Blue background
                  child: Text(
                    'Today', // Text to display
                    style: TextStyle(
                      color: Colors.white, // White text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.sp), // Responsive spacing
              ],
              // Render event indicator if there are events
              if (events.isNotEmpty) ...[
                Container(
                  color: events.first.color,
                  height: double.maxFinite,
                  width: 3.w, // Responsive width
                ),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(3.sp), // Responsive padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          events.isNotEmpty ? events.first.title : '',
                          style: TextStyle(
                            fontSize: 12.sp, // Responsive font size
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                          maxLines: 1, // Limit to one line
                        ),
                      ),
                      Flexible(
                        child: Text(
                          events.isNotEmpty
                              ? events.first.event.toString()
                              : '',
                          style: TextStyle(
                            fontSize: 10.sp, // Responsive font size
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                          maxLines: 1, // Limit to one line
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      weekPageHeaderBuilder: (startDate, endDate) => Container(
          // Header customization can be added here
          ),
      onEventTap: (events, date) {
        // Show alert dialog with event details
        if (events.isNotEmpty) {
          controller.selectedEvent.value = events;
          print(controller.selectedEvent);
        }
      },
    ),
  );
}
  Widget _buildDayView(CalendarController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: DayView(
          controller: controller.eventController.value,
          onPageChange: (DateTime date, int pageIndex) {
            controller.onMonthChanged(date);
            controller.selectedDate.value = date;
          },
          // Use the observable eventController
          showVerticalLine: true,
          minDay: DateTime(2024, 1, 1),
          maxDay: DateTime(2024, 12, 31),
          initialDay: controller.selectedDate.value ??
              DateTime.now(), // Use reactive selectedDate
          timeLineBuilder: (total) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    '${total.hour.toString().padLeft(2, '0')}:00',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
          eventTileBuilder: (date, events, boundary, start, end) {
            return Container(
              margin:
                  const EdgeInsets.all(4), // Add margin around the event tile
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 236, 236, 236), // Use the event color
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Container(
                    color: events.isNotEmpty
                        ? events.first.color
                        : Colors.transparent, // Use the event color
                    height: 100,
                    width: 4,
                  ),
                  Expanded(
                    // Use Expanded to allow the text to take available space
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            // Use Flexible to allow text to wrap
                            child: Text(
                              events.isNotEmpty ? events.first.title : '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                              ),
                              maxLines: 1, // Limit to one line
                            ),
                          ),
                          Flexible(
                            // Use Flexible for the event description
                            child: Text(
                              events.isNotEmpty
                                  ? events.first.event.toString()
                                  : '',
                              style: const TextStyle(
                                fontSize: 8,
                                overflow:
                                    TextOverflow.ellipsis, // Handle overflow
                              ),
                              maxLines: 1, // Limit to one line
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 151, 195, 231),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 18,
                              width: 60,
                              child: const Center(
                                child: Text(
                                  "Scheduled",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          dayTitleBuilder: (date) => Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEE')
                      .format(date)
                      .toUpperCase(), // Day of the week
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${date.day}', // Day of the month
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          onEventTap: (events, date) {
            // Show alert dialog with event details
            if (events.isNotEmpty) {
              // _showEventDetailsDialog(context, events.first);
              // print(events.first);
              controller.selectedEvent.value = events;
              print(controller.selectedEvent);
              _eventList(controller);
              controller.currentDate.value = date;
            }
          },
        ),
      ),
    );
  }

  Widget _eventList(CalendarController controller) {
    final DateTime selectedDate =
        controller.selectedDate.value ?? DateTime.now();

    final List<CalendarEventData> eventsForSelectedDate = controller.allEvents
        .where((event) =>
            event.date.year == selectedDate.year &&
            event.date.month == selectedDate.month &&
            event.date.day == selectedDate.day)
        .toList();

    final bool hasEvents =
        controller.selectedEvent.isNotEmpty || eventsForSelectedDate.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Divider(
              thickness: 4, color: Color.fromARGB(255, 218, 219, 219)),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  // Display the selected date
                  Container(
                    color: Colors.transparent,
                    height: 200,
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, top: 4, left: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            controller.selectedEvent.isNotEmpty
                                ? DateFormat('EEE')
                                    .format(controller.currentDate.value)
                                    .toUpperCase()
                                : DateFormat('EEE')
                                    .format(selectedDate)
                                    .toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.selectedEvent.isNotEmpty
                                ? DateFormat('d')
                                    .format(controller.selectedEvent.first.date)
                                    .toUpperCase()
                                : '${selectedDate.day}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: hasEvents
                        ? SizedBox(
                            height: 200, // Set a fixed height for the ListView
                            child: ListView.builder(
                              itemCount: controller.selectedEvent.isNotEmpty
                                  ? controller.selectedEvent.length
                                  : eventsForSelectedDate.length,
                              itemBuilder: (context, index) {
                                final event =
                                    controller.selectedEvent.isNotEmpty
                                        ? controller.selectedEvent[index]
                                        : eventsForSelectedDate[index];
                                final startTime = event.startTime ??
                                    DateTime.now(); // Default to now if null
                                final endTime = event.endTime ?? DateTime.now();

                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color: Colors.grey),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 5,
                                            color: event.color,
                                            height: 70,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  event
                                                      .title, // Event title from the event data
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: CircleAvatar(
                                                        radius: 3,
                                                        backgroundColor:
                                                            event.color,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${event.description} | ${event.event.toString()} | ${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}",
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              100,
                                                              100,
                                                              100),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text(
                              "No Events",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
