
import 'package:calender/app/controllers/controller.dart';
import 'package:get/get.dart';

class CalendarBinding extends Bindings {

  @override
  void dependencies () {
    Get.lazyPut<CalendarController>(() => CalendarController());
  }

  
}