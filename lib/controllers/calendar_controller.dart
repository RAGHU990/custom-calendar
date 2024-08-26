import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart'; // Make sure this import is correct

class CalendarController extends GetxController {
  // Observable EventController instance
  final Rx<EventController> eventController = EventController().obs;

  // Observable selected date
  var selectedDate = DateTime.now().obs;

  // Observable current month
  var currentMonth = DateTime.now().obs;

  // List of all events as an observable
  final RxList<CalendarEventData> allEvents = <CalendarEventData>[].obs;

  @override
  void onInit() {
    super.onInit();
    _addEvents();
  }

  // Method to update the selected date
  void onDateSelected(DateTime date) {
    selectedDate.value = date;
  }

  // Method to update the events list
  void updateEvents(List<CalendarEventData> events) {
    allEvents.value = events;
  }

  // Add initial events
  void _addEvents() {
    // Initialize the events list
    allEvents.addAll([
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.blue,
        event: const {"event_type": "Scheduled", "eventId": "APP001"},
        title: "Mahindra Logistics",
        description: "Logistics event",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: const {"event_type": "Scheduled", "eventId": "APP001"},
        title: "Mahindra Logistics",
        description: "Logistics event",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 23),
        color: Colors.red,
        event: const {"event_type": "Scheduled", "eventId": "APP001"},
        title: "Mahindra Logistics",
        description: "Logistics event",
        startTime: DateTime(2024, 8, 23, 14, 0),
        endTime: DateTime(2024, 8, 23, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 24),
        color: Colors.red,
        event: const {"event_type": "Scheduled", "eventId": "APP001"},
        title: "Mahindra Logistics",
        description: "Logistics event",
        startTime: DateTime(2024, 8, 24, 14, 0),
        endTime: DateTime(2024, 8, 24, 15, 0),
      ),
    ]);
  }

  // Method to update the current month
  void onMonthChanged(DateTime newMonth) {
    currentMonth.value = newMonth;
  }

  // Method to set the selected date
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  // Get events for the selected date
  List<CalendarEventData> eventsForSelectedDate() {
    return allEvents
        .where((event) =>
            event.date.year == selectedDate.value.year &&
            event.date.month == selectedDate.value.month &&
            event.date.day == selectedDate.value.day)
        .toList();
  }

  Map<DateTime, List<Color>> collectColorsByDate(
      List<CalendarEventData> allEvents) {
    // Create a map to hold the colors for each date
    Map<DateTime, List<Color>> colorsByDate = {};

    // Iterate over all events
    for (var event in allEvents) {
      // Create a key for the event's date (without time)
      DateTime eventDate =
          DateTime(event.date.year, event.date.month, event.date.day);

      // If the date is not already in the map, initialize it with an empty list
      if (!colorsByDate.containsKey(eventDate)) {
        colorsByDate[eventDate] = [];
      }

      // Add the event's color to the list for that date
      colorsByDate[eventDate]!.add(event.color);
    }

    return colorsByDate;
  }
}
