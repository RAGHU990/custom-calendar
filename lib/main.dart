import 'package:calender/app/controllers/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/views/calendar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const CalendarPage(),
      initialBinding: CalendarBinding(),
    );
  }
}
