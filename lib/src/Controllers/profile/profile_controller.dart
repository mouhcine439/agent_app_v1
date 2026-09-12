import 'dart:convert';
import 'dart:developer';

import 'package:agentapp/src/constants/app_strings.dart';
import 'package:agentapp/src/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  ProfileModel? profileModel;
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      Uri url = Uri.parse("${AppString.baseUrl}/profile");
      var response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        profileModel = ProfileModel.fromMap(responseBody);
      }
    } catch (e) {
      log("error catch $e");
    } finally {
      isLoading.value = false;
    }
  }
}
