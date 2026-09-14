enum AlertType {
  warning,
  error,
  info,
  success,
}

class AlertModel {
  const AlertModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String message;
  final String date;
  final AlertType type;
  final bool isRead;
}

final List<AlertModel> mockAlerts = [
  const AlertModel(
    id: 'A001',
    title: 'Point de contrôle en attente',
    message: 'Le point "Salle de sécurité" doit être contrôlé.',
    date: 'Aujourd’hui, 14:25',
    type: AlertType.warning,
  ),
  const AlertModel(
    id: 'A002',
    title: 'Tournée terminée',
    message: 'La tournée "Contrôle qualité" est terminée.',
    date: 'Aujourd’hui, 12:10',
    type: AlertType.success,
    isRead: true,
  ),
  const AlertModel(
    id: 'A003',
    title: 'Connexion réseau',
    message: 'La connexion internet est momentanément indisponible.',
    date: 'Hier, 18:40',
    type: AlertType.error,
  ),
  const AlertModel(
    id: 'A004',
    title: 'Nouvelle tournée',
    message: 'Une nouvelle tournée vous a été affectée.',
    date: 'Hier, 09:30',
    type: AlertType.info,
  ),
];