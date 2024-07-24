import 'package:get/get.dart';

import 'package:teste/controller/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NewtworkController>(NewtworkController(), permanent: true);
  }
}
