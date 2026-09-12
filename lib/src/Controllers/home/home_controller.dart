import 'dart:convert';
import 'dart:developer';

import 'package:agentapp/src/models/test_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  RxList<TestModel> listItems = <TestModel>[].obs;
  RxBool isLoading = false.obs;
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        log("success status code ${response.body}");
        List<dynamic> responseBody = jsonDecode(response.body);
        listItems.value =
            responseBody.map((e) => TestModel.fromJson(e)).toList();
      } else {
        log("error status code ${response.statusCode}");
      }
    } catch (e) {
      log("error catch $e");
    } finally {
      isLoading.value = false;
    }
  }
}
