import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart'; // Make sure this import is correct
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  // Observable EventController instance
  Rx<EventController> eventController = EventController().obs;

  // Observable selected date
  var selectedDate = DateTime.now().obs;

  // Observable current month
  var currentMonth = DateTime.now().obs;

  // Observable current week start and end dates
  var weekStartDate = DateTime.now().obs;
  var weekEndDate = DateTime.now().obs;
    var currentDate = DateTime.now().obs;

  

  // List of all events as an observable
  final RxList<CalendarEventData> allEvents = <CalendarEventData>[].obs;
  final RxList<CalendarEventData> selectedEvent = <CalendarEventData>[].obs;


  @override
  void onInit() {
    super.onInit();
    _addMonth();
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
    eventController.value.addAll([
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.blue,
        event: "APP112",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "AP0292",
        title: "BMW",
        description: "Completed",
        startTime: DateTime(2024, 8, 22, 10, 30),
        endTime: DateTime(2024, 8, 22, 12, 30),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "AP7592",
        title: "Benz",
        description: "Completed",
        startTime: DateTime(2024, 8, 22, 10, 30),
        endTime: DateTime(2024, 8, 22, 12, 30),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.blue,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 23),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 23, 14, 0),
        endTime: DateTime(2024, 8, 23, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 24),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 24, 14, 0),
        endTime: DateTime(2024, 8, 24, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 26),
        color: Colors.blue,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 26, 14, 0),
        endTime: DateTime(2024, 8, 26, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 26),
        color: Colors.red,
        event: "APP001",
        title: "Flipkart",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 26, 12, 0),
        endTime: DateTime(2024, 8, 26, 12, 15),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 26),
        color: Colors.blue, // You can choose any color you prefer
        event: "APP002", // Unique identifier for the event
        title: "Test", // Event title
        description: "Scheduled", // Description of the event
        startTime: DateTime(2024, 8, 26, 15, 0), // Start time
        endTime: DateTime(2024, 8, 26, 18, 0), // End time (1:00 PM)
      )
    ]);
  }

  void _addMonth() {
    // Initialize the events list
    allEvents.addAll([
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.blue,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.blue,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 22),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 22, 10, 0),
        endTime: DateTime(2024, 8, 22, 12, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 23),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 23, 14, 0),
        endTime: DateTime(2024, 8, 23, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 24),
        color: Colors.red,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 24, 14, 0),
        endTime: DateTime(2024, 8, 24, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 26),
        color: Colors.blue,
        event: "APP001",
        title: "Mahindra Logistics",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 26, 14, 0),
        endTime: DateTime(2024, 8, 26, 15, 0),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 26),
        color: Colors.red,
        event: "APP001",
        title: "Flipkart",
        description: "Scheduled",
        startTime: DateTime(2024, 8, 26, 12, 0),
        endTime: DateTime(2024, 8, 26, 12, 15),
      ),
      CalendarEventData(
        date: DateTime(2024, 8, 26),
        color: Colors.blue, // You can choose any color you prefer
        event: "APP002", // Unique identifier for the event
        title: "Test", // Event title
        description: "Scheduled", // Description of the event
        startTime: DateTime(2024, 8, 26, 15, 0), // Start time
        endTime: DateTime(2024, 8, 26, 18, 0), // End time (1:00 PM)
      )
    ]);
  }

  // Method to update the current month
  void onMonthChanged(DateTime newMonth) {
    currentMonth.value = newMonth;
  }

  // Method to change the week
  void onWeekChanged(DateTime newWeekStart) {
    selectedDate.value =
        newWeekStart; // Set the selected date to the start of the new week
    _updateWeekDates(newWeekStart); // Update week start and end dates
  }

  // Private method to update week start and end dates based on a given date
  void _updateWeekDates(DateTime date) {
    weekStartDate.value = date.subtract(
        Duration(days: date.weekday - 1)); // Get the start of the week (Monday)
    weekEndDate.value = weekStartDate.value
        .add(Duration(days: 6)); // Get the end of the week (Sunday)
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

  @override
  void onClose() {
    debugPrint("onclose");
    super.onClose();
  }
}
