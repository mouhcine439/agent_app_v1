enum CheckpointStatus {
  pending,
  inProgress,
  done,
}

class CheckpointModel {
  const CheckpointModel({
    required this.id,
    required this.title,
    required this.location,
    required this.status,
    this.description,
    this.distance,
  });

  final String id;
  final String title;
  final String location;
  final CheckpointStatus status;
  final String? description;
  final double? distance;
}

/// Données temporaires pour construire l'interface.
/// Elles seront remplacées par les données de l'API plus tard.
List<CheckpointModel> mockCheckpointsFor(String tourId) {
  return [
    const CheckpointModel(
      id: 'CP001',
      title: 'Entrée principale',
      location: 'Porte principale',
      status: CheckpointStatus.done,
      description: 'Contrôle de l’entrée principale du site.',
      distance: 4,
    ),
    const CheckpointModel(
      id: 'CP002',
      title: 'Parking',
      location: 'Parking visiteurs',
      status: CheckpointStatus.done,
      description: 'Vérification du parking.',
      distance: 8,
    ),
    const CheckpointModel(
      id: 'CP003',
      title: 'Zone de stockage',
      location: 'Bâtiment A',
      status: CheckpointStatus.inProgress,
      description: 'Contrôle de la zone de stockage.',
      distance: 5,
    ),
    const CheckpointModel(
      id: 'CP004',
      title: 'Salle de sécurité',
      location: 'Bâtiment principal',
      status: CheckpointStatus.pending,
      description: 'Vérification de la salle de sécurité.',
      distance: 12,
    ),
    const CheckpointModel(
      id: 'CP005',
      title: 'Sortie de secours',
      location: 'Bâtiment B',
      status: CheckpointStatus.pending,
      description: 'Contrôle de la sortie de secours.',
      distance: 15,
    ),
  ];
}