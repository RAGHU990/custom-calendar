

import 'package:calendar_view/calendar_view.dart';
import 'package:calender/app/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekViewWidget extends GetView<CalendarController> {
  const WeekViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return WeekView<CalendarEventData<Object?>>(
        
        eventTileBuilder: (date, events, boundry, start, end) {
          if (events.isNotEmpty) {
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: events.map((event) {
                  return Text(
                    event.title,
                    style: const TextStyle(color: Colors.white),
                  );
                }).toList(),
              ),
            );
          }
          return SizedBox.shrink();
        },
      
        heightPerMinute: 1,
        eventArranger: SideEventArranger(),
      );
    });
  }
}
