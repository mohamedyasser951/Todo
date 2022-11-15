import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/services.dart';
import 'package:todo/services/themeservice.dart';
import 'package:todo/view/Taskpage.dart';
import 'package:todo/view/home.dart';
import 'package:todo/view/spalashscreen.dart';
import 'package:todo/view/themes.dart';
import 'package:todo/view/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initalService();
  
  runApp(MyApp());
}

Future<SettingServices> initalService() async {
  return Get.putAsync(() => SettingServices().init());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: Spalash(),
    );
  }
}
