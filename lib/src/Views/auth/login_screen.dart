import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_button.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifiantController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifiantController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword && _obscurePassword,
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 15.0),
          cursorColor: AppColors.goldColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.whiteColor.withValues(alpha: 0.08),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.greyColor.withValues(alpha: 0.7),
              fontSize: 14.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.goldColor, width: 1.5),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.greyColor,
                      size: 20,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  void _onLoginPressed() {
    // TODO: brancher l'authentification réelle (API + cache local).
    Get.offAllNamed(NameRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.goldColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: AppColors.primaryColor,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: CustomText(
                    title: "Safaa",
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: CustomText(
                    title: "Tournées de contrôle terrain",
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(height: 40),
                _buildField(
                  label: "Identifiant",
                  controller: _identifiantController,
                  hint: "agent.dupont",
                ),
                const SizedBox(height: 20),
                _buildField(
                  label: "Mot de passe",
                  controller: _passwordController,
                  hint: "••••••••",
                  isPassword: true,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  onPressed: _onLoginPressed,
                  bgColorButton: AppColors.goldColor,
                  title: "Se connecter",
                  colorText: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}