import 'package:calender/bindings/binding.dart';
import 'package:calender/routes/routes_name.dart';
import 'package:calender/views/calendar_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutesName.calendar,
      page: () => CalendarPage(),
      binding: CalendarBinding(),
    )
  ];
}
