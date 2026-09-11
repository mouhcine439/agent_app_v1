import 'package:agentapp/src/models/checkpoint_model.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  late TourModel tour;
  late CheckpointModel checkpoint;

  final RxBool isScanning = false.obs;
  final RxBool isVerified = false.obs;

  final RxDouble distance = 4.0.obs;

  void initialize({
    required TourModel selectedTour,
    required CheckpointModel selectedCheckpoint,
  }) {
    tour = selectedTour;
    checkpoint = selectedCheckpoint;

    distance.value =
        selectedCheckpoint.distance ?? 4;
  }

  Future<void> simulateScan() async {
    if (isScanning.value || isVerified.value) {
      return;
    }

    isScanning.value = true;

    // Simulation temporaire.
    // Plus tard :
    // 1. Scan QR/NFC
    // 2. Vérification du code
    // 3. Vérification GPS
    // 4. Appel API
    await Future.delayed(
      const Duration(seconds: 1),
    );

    isScanning.value = false;
    isVerified.value = true;
  }

  void resetScan() {
    isVerified.value = false;
    isScanning.value = false;
  }
}