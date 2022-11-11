import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingServices extends GetxService {
  Future<SettingServices> init() async {
    await GetStorage.init();

    return this;
  }
}
