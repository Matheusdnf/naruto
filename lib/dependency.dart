import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teste/controler/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NewtworkController>(NewtworkController(), permanent: true);
  }
}
