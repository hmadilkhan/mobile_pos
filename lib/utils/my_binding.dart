import 'package:get/get.dart';
import 'package:mobile_pos/controllers/pos_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PosController());
  }
}
