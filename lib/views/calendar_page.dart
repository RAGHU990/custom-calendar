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
          minMonth: DateTime(1900),
          maxMonth: DateTime(2100),
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
                controller.selectedEvent.clear();
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
                      if (isToday)
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            fontWeight:
                                isToday ? FontWeight.bold : FontWeight.bold,
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

  Widget _buildWeekView(CalendarController controller, BuildContext context) {
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
                  const SizedBox(width: 8), // Spacing between avatar and events
                ],
                // Render event indicator if there are events
                if (events.isNotEmpty) ...[
                  Container(
                    color: events.first.color,
                    height: double.maxFinite,
                    width: 3,
                  ),
                ],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
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
                          child: Text(
                            events.isNotEmpty
                                ? events.first.event.toString()
                                : '',
                            style: const TextStyle(
                              fontSize: 10,
                              overflow:
                                  TextOverflow.ellipsis, // Handle overflow
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
            // _showEventDetailsDialog(context, events.first);
            // print(events.first);
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
                color:
                    Color.fromARGB(255, 236, 236, 236), // Use the event color
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
                      .format(controller.selectedDate.value)
                      .toUpperCase(), // Day of the week
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${controller.selectedDate.value.day}', // Day of the month
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
                          controller.selectedEvent.isNotEmpty
                              ? DateFormat('EEE')
                                  .format(controller.selectedEvent.first.date)
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200, // Set a fixed height for the ListView
             child:    ListView.builder(
  itemCount: controller.selectedEvent.isNotEmpty ?  controller.selectedEvent.length :eventsForSelectedDate.length ,
  itemBuilder: (context, index) {
    final event = controller.selectedEvent.isNotEmpty
    ? controller.selectedEvent[index]

        : eventsForSelectedDate[index];
        
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
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                color: event.color, // Use event color
                height: 70,
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title, // Event title from the event data
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "helli",
                      style: TextStyle(
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
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
)
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
