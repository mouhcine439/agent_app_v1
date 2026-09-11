enum QuestionType {
  yesNo,
  text,
  choice,
}

class QuestionModel {
  const QuestionModel({
    required this.id,
    required this.question,
    required this.type,
    this.options = const [],
    this.required = true,
  });

  final String id;
  final String question;
  final QuestionType type;
  final List<String> options;
  final bool required;
}

final List<QuestionModel> mockQuestions = [
  const QuestionModel(
    id: 'Q001',
    question: 'La zone est-elle propre et correctement entretenue ?',
    type: QuestionType.yesNo,
  ),
  const QuestionModel(
    id: 'Q002',
    question: 'Les équipements de sécurité sont-ils présents ?',
    type: QuestionType.yesNo,
  ),
  const QuestionModel(
    id: 'Q003',
    question: 'L’accès à la zone est-il sécurisé ?',
    type: QuestionType.yesNo,
  ),
  const QuestionModel(
    id: 'Q004',
    question: 'Quel est l’état général de la zone ?',
    type: QuestionType.choice,
    options: [
      'Bon',
      'Moyen',
      'Mauvais',
      'Critique',
    ],
  ),
  const QuestionModel(
    id: 'Q005',
    question: 'Ajoutez un commentaire si nécessaire.',
    type: QuestionType.text,
    required: false,
  ),
];