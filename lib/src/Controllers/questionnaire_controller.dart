import 'package:agentapp/src/models/question_model.dart';
import 'package:get/get.dart';

class QuestionnaireController extends GetxController {
  final RxInt currentQuestionIndex = 0.obs;

  final RxMap<String, String> answers = <String, String>{}.obs;

  final RxBool isSubmitting = false.obs;

  late final List<QuestionModel> questions;

  void initialize() {
    questions = mockQuestions;
    currentQuestionIndex.value = 0;
    answers.clear();
  }

  QuestionModel get currentQuestion {
    return questions[currentQuestionIndex.value];
  }

  bool get isLastQuestion {
    return currentQuestionIndex.value == questions.length - 1;
  }

  double get progress {
    if (questions.isEmpty) return 0;

    return (currentQuestionIndex.value + 1) / questions.length;
  }

  void setAnswer(String value) {
    answers[currentQuestion.id] = value;
  }

  String? getAnswer(String questionId) {
    return answers[questionId];
  }

  bool canContinue() {
    if (!currentQuestion.required) {
      return true;
    }

    final answer = answers[currentQuestion.id];

    return answer != null && answer.trim().isNotEmpty;
  }

  void nextQuestion() {
    if (!canContinue()) return;

    if (!isLastQuestion) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  Future<bool> submit() async {
    if (!canContinue()) {
      return false;
    }

    isSubmitting.value = true;

    // Simulation de l'appel API
    await Future.delayed(
      const Duration(seconds: 1),
    );

    isSubmitting.value = false;

    return true;
  }
}