import 'package:get/get.dart';
import 'package:marvel/presentation/controller.dart';


class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}