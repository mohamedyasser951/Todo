import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/view/themes.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = "isDark";

  saveModeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool get loadThemeFromBox => _box.read(_key) ?? false;
   ThemeMode get theme => loadThemeFromBox ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox ? ThemeMode.light : ThemeMode.dark);
    saveModeToBox(!loadThemeFromBox);
  }
}
