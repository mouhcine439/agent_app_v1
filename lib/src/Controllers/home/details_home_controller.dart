import 'package:agentapp/src/models/test_model.dart';
import 'package:get/get.dart';

class DetailsHomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _getDataFromArgument();
  }

  TestModel? testModel;
  void _getDataFromArgument() {
    if (Get.arguments != null) {
      testModel = Get.arguments['details'];
    }
  }
}
