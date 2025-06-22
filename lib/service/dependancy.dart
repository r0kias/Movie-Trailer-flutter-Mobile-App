import 'package:get/get.dart';
import 'package:secondd_ui/service/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
