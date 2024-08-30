import 'package:calender/app/bindings/binding.dart';
import 'package:calender/app/routes/routes_name.dart';
import 'package:calender/app/views/calendar_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutesName.calendar,
      page: () => const  CalendarPage(),
      binding: CalendarBinding(),
    )
  ];
}
