import 'package:agentapp/src/Controllers/questionnaire_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/question_model.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_button.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({
    super.key,
  });

  @override
  State<QuestionnaireScreen> createState() =>
      _QuestionnaireScreenState();
}

class _QuestionnaireScreenState
    extends State<QuestionnaireScreen> {
  late final QuestionnaireController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      QuestionnaireController(),
    );

    controller.initialize();
  }

  @override
  void dispose() {
    Get.delete<QuestionnaireController>();
    super.dispose();
  }

  Future<void> _continue() async {
    if (!controller.canContinue()) {
      Get.snackbar(
        'Réponse requise',
        'Veuillez répondre à la question.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.warningColor,
        colorText: AppColors.whiteColor,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    if (!controller.isLastQuestion) {
      controller.nextQuestion();
      return;
    }

    final success = await controller.submit();

    if (!success) return;

    Get.dialog(
      AlertDialog(
        title: const Text(
          'Questionnaire terminé',
        ),
        content: const Text(
          'Toutes les réponses ont été enregistrées.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildYesNoQuestion(
    QuestionModel question,
  ) {
    final selected =
        controller.getAnswer(question.id);

    return Column(
      children: [
        _AnswerButton(
          label: 'Oui',
          icon: Icons.check_circle_outline,
          selected: selected == 'Oui',
          onTap: () {
            controller.setAnswer('Oui');
          },
        ),
        const SizedBox(height: 12),
        _AnswerButton(
          label: 'Non',
          icon: Icons.cancel_outlined,
          selected: selected == 'Non',
          onTap: () {
            controller.setAnswer('Non');
          },
        ),
      ],
    );
  }

  Widget _buildChoiceQuestion(
    QuestionModel question,
  ) {
    final selected =
        controller.getAnswer(question.id);

    return Column(
      children: question.options.map(
        (option) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: _AnswerButton(
              label: option,
              icon: Icons.radio_button_checked,
              selected: selected == option,
              onTap: () {
                controller.setAnswer(option);
              },
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildTextQuestion(
    QuestionModel question,
  ) {
    final textController = TextEditingController(
      text: controller.getAnswer(question.id) ?? '',
    );

    return TextField(
      controller: textController,
      maxLines: 5,
      onChanged: controller.setAnswer,
      decoration: InputDecoration(
        hintText: 'Votre commentaire...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppbar(
          title: 'Questionnaire',
          showBtn: true,
          showBtnSearch: false,
          centerTitle: false,
        ),
        body: Obx(
          () {
            final question =
                controller.currentQuestion;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title:
                            'Question ${controller.currentQuestionIndex + 1}/${controller.questions.length}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      CustomText(
                        title:
                            '${(controller.progress * 100).round()}%',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: controller.progress,
                    minHeight: 7,
                    borderRadius:
                        BorderRadius.circular(10),
                    backgroundColor:
                        AppColors.greyColor.withOpacity(
                      0.2,
                    ),
                    valueColor:
                        const AlwaysStoppedAnimation(
                      AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomText(
                    title: question.question,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: SingleChildScrollView(
                      child: switch (question.type) {
                        QuestionType.yesNo =>
                          _buildYesNoQuestion(
                            question,
                          ),
                        QuestionType.choice =>
                          _buildChoiceQuestion(
                            question,
                          ),
                        QuestionType.text =>
                          _buildTextQuestion(
                            question,
                          ),
                      },
                    ),
                  ),
                  Row(
                    children: [
                      if (controller.currentQuestionIndex >
                          0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              controller.previousQuestion();
                            },
                            child: const Text(
                              'Précédent',
                            ),
                          ),
                        ),
                      if (controller.currentQuestionIndex >
                          0)
                        const SizedBox(width: 12),
                    Expanded(
  child: CustomButton(
    title: controller.isLastQuestion
        ? 'Terminer'
        : 'Continuer',
    onPressed: _continue,
    bgColorButton: AppColors.primaryColor,
    colorText: AppColors.whiteColor,
  ),
),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor.withOpacity(
                  0.08,
                )
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primaryColor
                : AppColors.greyColor.withOpacity(
                    0.4,
                  ),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? AppColors.primaryColor
                  : AppColors.greyColor,
            ),
            const SizedBox(width: 12),
            CustomText(
              title: label,
              fontSize: 15,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}