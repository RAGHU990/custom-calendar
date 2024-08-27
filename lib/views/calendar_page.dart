// views/calendar_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart';
import '../controllers/calendar_controller.dart';
import 'package:intl/intl.dart'; // Import the intl package

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    height: 465,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 20, left: 16),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " ${DateFormat('MMMM').format(controller.currentMonth.value)} ${controller.currentMonth.value.year}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff7c8388)),
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
                                      size: 30,
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
                            Tab(text: '          Month                    '),
                            Tab(
                                text:
                                    '             Week                             '),
                            Tab(text: '            Day                       '),
                          ],
                        ),
                        Expanded(
                          child: Obx(
                            () => TabBarView(
                              children: [
                                _buildMonthView(controller),
                                _buildWeekView(controller),
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
    );
  }

  Widget _buildMonthView(CalendarController controller) {
    // print("object1");
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: MonthView<Object?>(
          headerBuilder: (DateTime date) => Container(),
          controller: controller.eventController.value,
          initialMonth: DateTime.now(),
          minMonth: DateTime(2024, 1, 1),
          maxMonth: DateTime(2024, 12, 31),
          cellBuilder: (date, events, isToday, isInMonth, isSelected) {
            // print(date);

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
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelectedDate
                        ? Colors.grey
                        : Colors.grey.withOpacity(0.2),
                    width: isSelectedDate ? 2 : 0.01,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isInMonth ? Colors.black : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      if (eventsForDate.isNotEmpty) const SizedBox(height: 4),
                      if (eventsForDate.isNotEmpty && eventColors.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: eventColors.map((color) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: CircleAvatar(
                                radius: 3,
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
                const SizedBox(height: 10),
                Text(
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 10),
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

  Widget _buildWeekView(CalendarController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: WeekView<Object?>(
        controller: controller
            .eventController.value, // Use the observable event controller
        showLiveTimeLineInAllDays: true,
        minDay: DateTime(2024, 1, 1),
        maxDay: DateTime(2024, 12, 31),
        initialDay: controller
            .selectedDate.value, // Use the selected date from the controller
        timeLineBuilder: (total) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${total.hour.toString().padLeft(2, '0')}:00',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          );
        },
            eventTileBuilder: (date, events, boundary, start, end) {
        // Customize how each event tile is displayed
        return Container(
          color: Colors.amber,
          child: Row(
            children: [
              Container(
                color: Colors.black,
                height: double.maxFinite,
                width: 3,
                // height : double.infinity,
                // width: double.infinity
              )
            ]
          )

        );
      
      },
   
        weekPageHeaderBuilder: (startDate, endDate) => Container(
          // padding: const EdgeInsets.all(8),
          // child: Text(
          //   '${DateFormat('MMMM d').format(startDate)} - ${DateFormat('MMMM d').format(endDate)}',
          //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
        ),
      ),
    );
  }

  // Day View Widget
  Widget _buildDayView(CalendarController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: DayView(
          controller: controller
              .eventController.value, // Use the observable eventController
          showVerticalLine: true,
          minDay: DateTime(2024, 1, 1),
          maxDay: DateTime(2024, 12, 31),
          initialDay: controller.selectedDate.value ??
              DateTime.now(), // Use reactive selectedDate
          timeLineBuilder: (total) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${total.hour.toString().padLeft(2, '0')}:00',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            );
          },
          eventTileBuilder: (date, events, boundary, start, end) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                events.isNotEmpty ? events.first.title : '',
                style: const TextStyle(color: Colors.black),
              ),
            );
          },
          dayTitleBuilder: (date) => Container(),
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

    return Column(
      children: [
        const SizedBox(height: 8),
        const Divider(thickness: 4, color: Color.fromARGB(255, 218, 219, 219)),
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
                          DateFormat('EEE')
                              .format(selectedDate)
                              .toUpperCase(), // Day of the week
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${selectedDate.day}', // Day of the month
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200, // Set a fixed height for the ListView
                        child: eventsForSelectedDate.isNotEmpty
                            ? ListView.builder(
                                itemCount: eventsForSelectedDate.length,
                                itemBuilder: (context, index) {
                                  final event = eventsForSelectedDate[index];
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
                                        )
                                      ],
                                    ),
                                    height: 70,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              color: event
                                                  .color, // Use event color
                                              height: 70,
                                              width: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        event
                                                            .title, // Event title from the event data
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      const Text(
                                                        "helli",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    100,
                                                                    100,
                                                                    100)),
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
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  "No Events",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
