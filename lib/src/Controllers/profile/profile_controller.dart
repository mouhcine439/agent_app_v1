import 'dart:convert';
import 'dart:developer';

import 'package:agentapp/src/constants/app_strings.dart';
import 'package:agentapp/src/helper/app_local.dart';
import 'package:agentapp/src/models/profile_model.dart';
import 'package:agentapp/src/routes/name_routes.dart';
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
      String token = await AppLocal.readDataLocal(key: 'token');
      var response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
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

  Future<void> logOut() async {
    try {
      isLoading.value = true;
      Uri url = Uri.parse("${AppString.baseUrl}/logout");
      String token = await AppLocal.readDataLocal(key: 'token');
      var response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        log("logout success ${response.body}");

        isLoading.value = false;
        await AppLocal.deleteDataLocal(key: 'token');
        Get.offAllNamed(NameRoutes.loginScreen);
      } else {
        isLoading.value = false;
        log("logout failed ${response.body}");
      }
    } catch (e) {
      log("error catch $e");
    } finally {
      isLoading.value = false;
    }
  }
}
