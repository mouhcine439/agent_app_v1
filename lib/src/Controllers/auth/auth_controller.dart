import 'package:agentapp/src/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  RxBool isLoading = false.obs;
  Future<void> login() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email');
      return;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter password');
      return;
    }
    try {
      isLoading.value = true;
      Uri url = Uri.parse('${AppString.baseUrl}/login');
      var response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': emailController.text,
          'password': passwordController.text
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', 'Login successful');
      } else {
        isLoading.value = false;
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  RxBool isAbstractPassword = true.obs;
  void togglePassword() {
    isAbstractPassword.toggle();
  }
}
