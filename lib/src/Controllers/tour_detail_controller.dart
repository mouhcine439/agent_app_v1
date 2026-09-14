import 'package:agentapp/src/models/checkpoint_model.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:get/get.dart';

class TourDetailController extends GetxController {
  late TourModel tour;

  final RxList<CheckpointModel> checkpoints =
      <CheckpointModel>[].obs;

  final RxBool isLoading = false.obs;

  void initialize(TourModel selectedTour) {
    tour = selectedTour;

    // Données temporaires.
    // Plus tard elles viendront de l'API.
    checkpoints.assignAll(
      mockCheckpointsFor(selectedTour.id),
    );
  }

  double get progress {
    if (checkpoints.isEmpty) {
      return 0;
    }

    final int completed = checkpoints
        .where(
          (checkpoint) =>
              checkpoint.status == CheckpointStatus.done,
        )
        .length;

    return completed / checkpoints.length;
  }

  int get completedCount {
    return checkpoints
        .where(
          (checkpoint) =>
              checkpoint.status == CheckpointStatus.done,
        )
        .length;
  }

  bool canOpenCheckpoint(CheckpointModel checkpoint) {
    return checkpoint.status != CheckpointStatus.pending;
  }
}