enum TourStatus { todo, inProgress, done }

class TourModel {
  const TourModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String id;
  final String title;
  final String subtitle;
  final TourStatus status;
}

/// Données factices le temps de brancher le stockage local (sqflite) / l'API.
final List<TourModel> mockTours = [
  const TourModel(
    id: '1',
    title: 'Ronde sécurité 14h',
    subtitle: 'Site Atlantis · 8 points',
    status: TourStatus.todo,
  ),
  const TourModel(
    id: '2',
    title: 'Contrôle qualité',
    subtitle: 'Site Marina · 5/12 points',
    status: TourStatus.inProgress,
  ),
  const TourModel(
    id: '3',
    title: 'Audit mensuel',
    subtitle: 'Site Twin Center · hier',
    status: TourStatus.done,
  ),
];