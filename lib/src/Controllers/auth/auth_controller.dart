import 'dart:convert';

import 'package:agentapp/src/constants/app_strings.dart';
import 'package:agentapp/src/helper/app_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _remmemberMe();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _remmemberMe() async {
    if (await AppLocal.readDataLocal(key: 'email') != '' &&
        await AppLocal.readDataLocal(key: 'password') != '') {
      emailController.text = await AppLocal.readDataLocal(key: 'email');
      passwordController.text = await AppLocal.readDataLocal(key: 'password');
    }
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
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        await AppLocal.saveDataLocal(
            key: 'token', value: responseBody['token']);
        await AppLocal.saveDataLocal(
          key: 'email',
          value: emailController.text,
        );
        await AppLocal.saveDataLocal(
          key: 'password',
          value: passwordController.text,
        );
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
